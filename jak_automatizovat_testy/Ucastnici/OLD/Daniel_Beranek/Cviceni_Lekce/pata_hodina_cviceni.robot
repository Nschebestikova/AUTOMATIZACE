# požadavky:
#   pip install robotframework-browser
#   rfbrowser init

*** Settings ***
Documentation   CV: akce pred testem a po skonceni testu
Library         Browser

Resource        Data_and_Config/TestData.robot
Resource        Data_and_Config/Configuration.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

*** Variables ***

${Email}        giyipem264@v1zw.com
${Heslo}        tajnenovak

*** Test Cases ***

Login - Uspesne prihlaseni
    Login                       ${USER1_EMAIL}                       ${USER1_PASSWORD}
    Uživatel je přihlášen
#    [Teardown]   Logout

Login - Chybne heslo
    Login                       ${USER1_EMAIL}                       chyba
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje

Login - Chybne jméno
    Login                       blbe@neco.cz                         ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje


Login - Prazdne heslo
    Login                       ${USER1_EMAIL}                       ${EMPTY}
    Uživatel není přihlášen
    Chybova hlaska prazdne heslo

Login - Prazdny email
    Login                       ${EMPTY}                             ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska prazdny email

*** Keywords ***
Login
   [Arguments]          ${Email}            ${Heslo}

   Click            ${SEL_LoginLink}
   Type Text        ${SEL_LoginFormEmail}           ${Email}
   Type Text        ${SEL_LoginFormPwd}             ${Heslo}
   Click            ${SEL_UserLoginBtn}
   Take Screenshot

Uživatel je přihlášen
    Get Text        ${SEL_UserLogoutBtn}            ==       ${TEXT_Ohlasit}
    Take Screenshot


Uživatel není přihlášen
    Get Text        ${SEL_LoginLink}                ==       ${TEXT_Prihlasit}
    Take Screenshot


Chybova hlaska neplatne udaje
       Get Text   ${SEL_LoginErrorTxt}       *=  ${ERROR_TEXT_IncorrectEmailOrPwd}   # AssertNeg1
       Take Screenshot

Chybova hlaska prazdny email
       Get Text   ${SEL_LoginErrorTxt}       *=  ${ERROR_TEXT_EmptyEmail}
       Take Screenshot

Chybova hlaska prazdne heslo
       Get Text   ${SEL_LoginIncorrectPwd}   *=  ${ERROR_TEXT_EmptyPwd}
       Take Screenshot

Pred_sadou
   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      ${TEXT_MainTitle}

Pred_testem
   Go To              ${URL}

Uklid_po_testu
   Go To              ${URL}

Uklid_sada
   Close Browser