*** Settings ***
Library  Browser
Documentation   Cvičení které mění umístění testovacích dat. Z místa přímo v testech na společný soubor
...             s testovacími daty, který je uložený v adresáři Data_and_Config

Resource     Data_and_Config/TestData.robot


*** Variables ***
${URL}      http://testovani.kitner.cz/courses
${USER1_USER_NAME}         giyipem264@v1zw.com
${USER1_PASSWORD}          tajnenovak
${USER1_SHORT}
${EMPTY_PASSWORD}          The password field is required.
${EMPTY_EMAIL}             The email field is required.
${WRONG_CREDENTIALS}       These credentials do not match our records.

*** Test Cases ***

Login - Uspesne prihlaseni
    Login                       ${USER1_USER_NAME}                  ${USER1_PASSWORD}
    Uživatel je přihlášen

Login - Chybne heslo
    Login                       ${USER1_USER_NAME}                  chyba
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje

Login - Chybne jméno
    Login                       blbe@neco.cz                         ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje


Login - Prazdne heslo
    Login                       ${USER1_USER_NAME}                  ${EMPTY}
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

   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}
   Type Text        data-test=password_input         ${Heslo}
   Click            data-test=login_button
   Take Screenshot

Uživatel je přihlášen
    Get Text        data-test=logout_button       ==       Odhlásit se
    Take Screenshot


Uživatel není přihlášen
    Get Text        data-test=login_link          ==       Přihlásit se
    Take Screenshot


Chybova hlaska neplatne udaje
       Get Text   data-test=email_input_errors  *=  ${WRONG_CREDENTIALS}   # AssertNeg1
       Take Screenshot

Chybova hlaska prazdny email
       Get Text   data-test=email_input_errors  *=  ${EMPTY_EMAIL}
       Take Screenshot

Chybova hlaska prazdne heslo
       Get Text   data-test=password_input_errors  *=  ${EMPTY_PASSWORD}  
       Take Screenshot

Chybova hlaska prazdne jmeno i heslo
       Get Text   data-test=email_input_errors  *=  ${EMPTY_EMAIL}
       Get Text   data-test=password_input_errors  *=  ${EMPTY_PASSWORD}
       Take Screenshot

