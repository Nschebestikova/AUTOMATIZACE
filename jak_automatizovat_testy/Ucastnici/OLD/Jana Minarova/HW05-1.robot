*** Settings ***
Library  Browser
Resource      Data_and_Config/TestData.robot
Resource      Data_and_Config/Configuration.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}      # Timeout pro všechny KS z RobotFW

Documentation   Cvičení které mění umístění testovacích dat.
*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Test Cases ***

Login - Uspesne prihlaseni
    Login                       ${USER1_EMAIL}                   ${USER1_PASSWORD}
    Uživatel je přihlášen
    [Teardown]        Logout

Login - Chybne heslo
    Login                       ${USER1_EMAIL}                   ${ERROR_TEXT_IncorrectEmailOrPwd}
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje

Login - Chybne jméno
    Login                       blbe@neco.cz                         ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje


Login - Prazdne heslo
    Login                       ${USER1_EMAIL}                  ${EMPTY}
    Uživatel není přihlášen
    Chybova hlaska prazdne heslo

Login - Prazdny email
    Login                       ${EMPTY}                             ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska prazdny email


*** Keywords ***
Login
   [Arguments]          ${Email}            ${Heslo}

   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      Testování - Přehled kurzů

   Click            ${SEL_LoginLink}
   Type Text        ${SEL_LoginFormEmail}            ${Email}
   Type Text        ${SEL_LoginFormPwd}         ${Heslo}
   Click            ${SEL_UserLoginBtn}
   Take Screenshot

Logout
   Click            ${SEL_UserLogoutBtn}

Uživatel je přihlášen
    Get Text        ${SEL_UserLogoutBtn}       ==       Odhlásit se
    Take Screenshot


Uživatel není přihlášen
    Get Text        ${SEL_LoginLink}          ==       Přihlásit se
    Take Screenshot


Chybova hlaska neplatne udaje
       Get Text   ${SEL_LoginIncorrectEmail}  *=  ${ERROR_TEXT_IncorrectEmailOrPwd}   # AssertNeg1
       Take Screenshot

Chybova hlaska prazdny email
       Get Text   ${SEL_LoginErrorTxt}   *=  ${ERROR_TEXT_EmptyEmail}
       Take Screenshot

Chybova hlaska prazdne heslo
       Get Text   ${SEL_LoginIncorrectPwd}  *=  ${ERROR_TEXT_EmptyPwd}
       Take Screenshot

Pred_sadou
    ${b_timeout} =     Set Browser Timeout                 ${TIMEOUT_BROWSER}
    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      ${TEXT_MainTitle}

Pred_testem
    Go to               ${URL}   #jdi na hlavní stránku

Uklid_po_testu
    Log         Uklid na konci každého testu.
    Go to       ${URL}

    #přidat odhlášení pokud je uživatel přihlášen
    ${menu} =   Get Text    ${SEL_Menu}
    Log to Console  ${menu}
    IF  "Odhlásit se" in "${menu}"
        Log  uživatel se musí odhlásit
        Logout
    ELSE
        Log  uživatel je již odhlášen
    END

Uklid_sada
    Close Browser
    