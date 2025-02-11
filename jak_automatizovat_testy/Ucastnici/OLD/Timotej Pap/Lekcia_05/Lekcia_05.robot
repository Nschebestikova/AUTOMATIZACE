*** Settings ***
Library  Browser
Documentation   Cvičení které mění umístění testovacích dat. Z místa přímo v testech na společný soubor
...             s testovacími daty, který je uložený v adresáři Data_and_Config

Resource        Data_and_Config/TestData.robot

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

Login - Uspesne prihlaseni
    Login                       ${USER1_EMAIL}                  ${USER1_PASSWORD}
    Uživatel je přihlášen

Login - Chybne heslo
    Login                       ${USER1_EMAIL}                  chyba
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
    Login                       ${EMPTY}                        ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska prazdny email

*** Keywords ***
Login
   [Arguments]          ${Email}            ${Heslo}

   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      ${TEXT_MainTitle}

   Click            ${SEL_LoginLink}
   Type Text        ${SEL_LoginFormEmail}           ${Email}
   Type Text        ${SEL_LoginFormPwd}             ${Heslo}
   Click            ${SEL_UserLoginBtn}
   Take Screenshot

Uživatel je přihlášen
    Get Text        ${SEL_UserLogoutBtn}       ==       ${TEXT_Ohlasit}
    Take Screenshot


Uživatel není přihlášen
    Get Text        ${SEL_LoginLink}          ==       ${TEXT_Prihlasit}
    Take Screenshot


Chybova hlaska neplatne udaje
       Get Text   ${SEL_LoginIncorrectEmail}  *=  ${ERROR_TEXT_IncorrectEmailOrPwd}   # AssertNeg1
       Take Screenshot

Chybova hlaska prazdny email
       Get Text   ${SEL_LoginIncorrectEmail}  *=  ${ERROR_TEXT_EmptyEmail}
       Take Screenshot

Chybova hlaska prazdne heslo
       Get Text   ${SEL_LoginIncorrectPwd}  *=  ${ERROR_TEXT_EmptyPwd}
       Take Screenshot
