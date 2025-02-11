*** Settings ***
Library         Browser
Resource        ../Data_and_Config/TestData.robot
Resource        ../Data_and_Config/Configuration.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}      # Timeout pro všechny KS z RobotFW

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
#Registrace
Registrace - úspěch
    Registrace uživatele    ${USER1_NAME}       ${USER1_EMAIL}                  ${USER1_PASSWORD}      Ano

Registrace - neúspěch (již registrovaný e-mail)
    Registrace uživatele    ${USER1_NAME}       ${USER1_EMAIL}                  ${USER1_PASSWORD}      Ne

#Přihlášení
Přihlášení - úspěch
    Login s kontrolou       ${USER1_EMAIL}              ${USER1_PASSWORD}       Ano

Přihlášení - neúspěch (chybný e-mail)
    Login s kontrolou       xameja1700+124@u.com        ${USER1_PASSWORD}       Ne

Přihlášení - neúspěch (chybné heslo)
    Login s kontrolou       ${USER1_EMAIL}              spatneheslo             Ne

#Odhlášení
Odhlášení - úspěch
    Login s kontrolou       ${USER1_EMAIL}          ${USER1_PASSWORD}      Ano
    Logout s kontrolou      Ano


*** Keywords ***
Registrace uživatele
    [Arguments]     ${jmeno}        ${email}        ${heslo}        ${registrovan}

    Log             ${jmeno}
    Log             ${email}
    Log             ${heslo}
    Log             ${registrovan}

    New Browser     chromium        headless=False
    New Page        ${URL}
    Get Title       ==              ${TEXT_MainTitle}
    Sleep           3

    Click           ${SEL_LoginLink}
    Click           ${SEL_RegisterLink}
    Get Text        ${SEL_RegisterText}
    Type Text       ${SEL_RegisterFormName}                     ${jmeno}
    Type Text       ${SEL_RegisterFormEmail}                    ${email}
    Type Text       ${SEL_RegisterFormPassword1st}              ${heslo}
    Type Text       ${SEL_RegisterFormPassword2nd}              ${heslo}
    Click           ${SEL_UserRegisterBtn}

    IF   "${registrovan}"=="Ano"
        Get Text          ${SEL_UserLogoutBtn}      ==    ${TEXT_Odhlasit}
        Log To Console    ${LOG_RegistrationSuccess}
    ELSE
        Get Text          ${SEL_UserRegisterBtn}    ==  ${TEXT_Registrovat}
        Log To Console    ${LOG_RegistrationUnsuccess}
    END

Login s kontrolou
   [Arguments]      ${email}    ${heslo}    ${prihlasen}

    Log             ${email}
    Log             ${heslo}
    Log             ${prihlasen}

    New Browser     chromium        headless=False
    New Page        ${URL}
    Get Title       ==              ${TEXT_MainTitle}

    Click           ${SEL_LoginLink}
    Type Text       ${SEL_LoginFormEmail}       ${email}
    Type Text       ${SEL_LoginFormPwd}         ${heslo}
    Click           ${SEL_UserLoginBtn}
    Sleep           3


    IF   "${prihlasen}"=="Ano"
        Get Text            ${SEL_UserLogoutBtn}        ==          ${TEXT_Odhlasit}
        Log To Console      ${LOG_LoginSuccess}
    ELSE
        Get Text            ${SEL_LoginLink}            ==          ${TEXT_Prihlasit}
        Log To Console      ${LOG_LoginUnsuccess}
    END

Logout s kontrolou
    [Arguments]         ${odhlasen}

    Log                 ${odhlasen}

    Click               ${SEL_UserLogoutBtn}

       ${MenuContent}=      Get Text                ${SEL_Menu}
   Log                  ${MenuContent}

   FOR    ${i}    IN RANGE      200
          sleep                 ${TIME_BETWEEN_CHECKS}
          ${MenuContent}=       Get Text         ${SEL_Menu}
          Exit For Loop If      'Přihlásit se' in '''${MenuContent}'''
          Log                   ${MenuContent}
          Log                   ${i}
   END


    IF   "${odhlasen}"=="Ano"
        Get Text            ${SEL_LoginLink}       ==       ${TEXT_Prihlasit}
        Log To Console      ${LOG_LogoutSuccess}
    ELSE
        Get Text            ${SEL_UserLogoutBtn}      ==      ${TEXT_Odhlasit}
        Log To Console      ${LOG_LogoutUnsuccess}
    END

#Suite Setup & Teardown
Pred_sadou
    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      ${TEXT_MainTitle}

Uklid_sada
    Close Browser

#Test Setup & Teardown
Pred_testem
    Go To           ${URL}

Uklid_po_testu
    Go To           ${URL}