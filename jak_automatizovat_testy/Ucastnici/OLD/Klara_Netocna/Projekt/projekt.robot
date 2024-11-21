*** Settings ***
Library  Browser
Documentation

Resource    Konfigurace.robot
Resource    TestData.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

Test Timeout         ${TC_TIMEOU_ROBOT_KW}

*** Test Cases ***

Login - Uspesne prihlaseni a odhlaseni
#   KS                          login                                heslo             Mám se přihlásit
    Login_s_kontrolou          ${USER1_EMAIL}                      ${USER1_PASSWORD}       Ano
    [Teardown]      Logout

Login - Neuspesne prihlaseni - chybne neexistujici jmeno
    Login_s_kontrolou           ${WRONG_EMAIL}                      ${USER1_PASSWORD}        Ne
    Chybova hlaska neplatne udaje

Login - Neuspesne prihlaseni - Chybne heslo
    Login_s_kontrolou           ${USER1_EMAIL}                      ${WRONG_PASSWORD}        Ne
    Chybova hlaska neplatne udaje

Registrace - uspesna
#   KS                          jmeno                       email                             heslo                          Zaregistroval se
    Uzivatel se zaregistruje    ${REGISTRATION_NICKNAME}    ${REGISTRATION_EMAIL}             ${REGISTRATION_PASSWORD}         Ano

Registrace - neuspesna - nespravny email
    Uzivatel se zaregistruje    ${REGISTRATION_NICKNAME}     ${REGISTRATION_WRONG_ PASSWORD}  ${USER1_PASSWORD}                 Ne

*** Keywords ***
Login_s_kontrolou
   [Arguments]      ${Email}            ${Heslo}            ${Text}

    Get Title  ==      ${TEXT_MainTitle}

    Click            ${SEL_LoginLink}
    Type Text        ${SEL_FormEmail}             ${Email}
    Type Text        ${SEL_FormPwd}          ${Heslo}
    Click            ${SEL_UserLoginBtn}

    IF   "${Text}"=="Ano"   #texty musi byt v uvozovkach
        Get Text          ${SEL_UserLogoutBtn}   ==  ${TEXT_Odhlasit}
        Log To Console    Je prihlasen
    ELSE
        Get Text          ${SEL_LoginLink}    ==   ${TEXT_Prihlasit}
        Log To Console    Neni prihlasen
    END

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        ${SEL_UserLogoutBtn}      ==       ${TEXT_Odhlasit}


Uživatel není přihlášen

    Get Text        ${SEL_LoginLink}          ==        ${TEXT_Prihlasit}

Chybova hlaska neplatne udaje
       Get Text   ${SEL_LoginErrorTxt}       *=  ${ERROR_TEXT_IncorrectEmailOrPwd}   # AssertNeg1
       Take Screenshot

Uzivatel se zaregistruje
    [Arguments]      ${Jmeno}           ${Email}            ${Heslo}            ${Text2}

    Get Title  ==      ${TEXT_MainTitle}

    Click            ${SEL_LoginLink}
    Click            ${SEL_RegisterLink}
    Get Text         ${SEL_RegisterText}
    Type Text        ${SEL_RegisterFormName}              ${Jmeno}
    Type Text        ${SEL_FormEmail}                     ${Email}
    Type Text        ${SEL_FormPwd}                       ${Heslo}
    Type Text        ${SEL_FormAgainPwd}                  ${Heslo}
    Click            ${SEL_RegisterButton}

    IF   "${Text2}"=="Ano"   #texty musi byt v uvozovkach
        Get Text          ${SEL_UserLogoutBtn}   ==  ${TEXT_Odhlasit}
        Log To Console    Je registrovan
    ELSE
        Get Text          ${SEL_RegisterButton}    ==   ${TEXT_Registrovat}
        Log To Console    Neni registrovan
    END
    [Teardown]      Logout

Logout
   Click            ${SEL_UserLogoutBtn}

Pred_sadou
   New Browser        headless=False
   New Page           ${URL}

Pred_testem
   Go To              ${URL}

Uklid_po_testu
   Go To              ${URL}

Uklid_sada
   Close Browser