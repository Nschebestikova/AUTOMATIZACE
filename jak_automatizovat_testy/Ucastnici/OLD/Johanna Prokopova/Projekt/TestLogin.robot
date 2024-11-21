*** Settings ***
Library         Browser

Resource        TestData.robot
Resource        Configuration.robot

Suite Setup     Pred_sadou
Suite Teardown  Po_sade

Test Setup      Pred_testem
Test Teardown   Po_testu

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}



*** Test Cases ***
Uspesny Login
    Login                        ${USER1_EMAIL}     ${USER1_PASSWORD}
    Prihlasen

Neuspesny Login - chybny email
    Login                        fffggg@hhh.com     ${USER1_PASSWORD}
    Neprihlasen
    Chybova hlaska neplatne udaje

Neuspesny Login - chybne heslo
    Login                        ${USER1_EMAIL}      budulinek
    Neprihlasen
    Chybova hlaska neplatne udaje
    # hlaska u emailu, ne u hesla

Neuspesny Login - prazdny email
    Login                        ${EMPTY}            ${USER1_PASSWORD}
    Neprihlasen
    Chybova hlaska prazdny email

Neuspesny Login - prazdne heslo
    Login                        ${USER1_EMAIL}        ${EMPTY}
    Neprihlasen
    Chybova hlaska prazdne heslo

Neuspesny Login - dlouhy email (za zavinacem 70 znaku)
    Login                       jah@fffggghhhjfffggghhhjfffggghhhjfffggghhhjfffggghhhjfffggghhhjfffggghhhj.com      ${USER1_PASSWORD}
    Neprihlasen
    Chybova hlaska neplatne udaje


*** Keywords ***
Login
   [Arguments]          ${Email}            ${Heslo}

   Click            ${SEL_LoginLink}
   Type Text        ${SEL_LoginFormEmail}            ${Email}
   Type Text        ${SEL_LoginFormPwd}              ${Heslo}
   Click            ${SEL_UserLoginBtn}
   Take Screenshot

Prihlasen
    Get Text                ${SEL_UserLogoutBtn}         ==  ${TEXT_Odhlasit}
    Take Screenshot

Neprihlasen
    Get Text                ${SEL_LoginLink}             ==  ${TEXT_Prihlasit}
    Take Screenshot

Chybova hlaska neplatne udaje
    Get Text                ${SEL_LoginErrorTxt}         *=  ${ERROR_TEXT_IncorrectEmailOrPwd}
    Take Screenshot

Chybova hlaska prazdny email
    Get Text                ${SEL_LoginIncorrectEmail}   *=  ${ERROR_TEXT_EmptyEmail}
    Take Screenshot

Chybova hlaska prazdne heslo
    Get Text                ${SEL_LoginIncorrectPwd}     *=  ${ERROR_TEXT_EmptyPwd}
    Take Screenshot

Pred_sadou
    ${b_timeput} =     Set Browser Timeout           ${TIMEOUT_BROWSER}
    New Browser        browser=${prohlizec}  headless=False
    New Page           ${URL}${URL_courses}
    Get Title  ==      ${TEXT_MainTitle}

Po_sade
    Close Browser

Pred_testem
    Go to               ${URL}${URL_courses}

Po_testu
    Go to       ${URL}${URL_courses}
    ${menu} =   Get Text    ${SEL_Menu}
    Log to Console  ${menu}
    IF  "Odhlásit se" in "${menu}"
         Log  uživatel není odhlášen
         Logout
    ELSE
         Log  uživatel je odhlášen
    END

Logout
   Click            ${SEL_UserLogoutBtn}
   ${MenuContent}=      Get Text                ${SEL_Menu}
   Log                  ${MenuContent}
   FOR    ${i}    IN RANGE    10
          sleep                   ${TIME_BETWEEN_CHECKS}
          ${Menu}=     Get Text         ${SEL_Menu}
          Exit For Loop If        "Přihlásit se" in "${Menu}"
          Log                     ${Menu}
          Log                     ${i}
   END
