*** Settings ***
Library    Browser
Resource   Data_and_Config/TestData.robot
Resource   Data_and_Config/Configuration.robot

Documentation   Cvičení které mění umístění testovacích dat. Z místa přímo v testech na společný soubor
...             s testovacími daty, který je uložený v adresáři Data_and_Config

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

Login - Uspesne prihlaseni
    Login                       ${USER1_EMAIL}                  ${USER1_PASSWORD}
    Uživatel je přihlášen

Login - Chybne heslo
    Login                       ${USER1_EMAIL}                  chybka
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje

Login - Chybne jméno
    Login                       n.schebestikova@seznam.cz                         ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje


Login - Prazdne heslo
    Login                       ${USER1_EMAIL}                   ${EMPTY}
    Uživatel není přihlášen
    Chybova hlaska prazdne heslo

Login - Prazdny email
    Login                       ${EMPTY}                             tajnenovak
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
       Get Text   data-test=email_input_errors  *=  These credentials do not match our records.   # AssertNeg1
       Take Screenshot

Chybova hlaska prazdny email
       Get Text   data-test=email_input_errors  *=  The email field is required.
       Take Screenshot

Chybova hlaska prazdne heslo
       Get Text   data-test=password_input_errors  *=  The password field is required.
       Take Screenshot
