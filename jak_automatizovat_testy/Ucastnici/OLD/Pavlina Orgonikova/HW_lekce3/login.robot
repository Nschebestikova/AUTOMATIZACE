*** Settings ***
Library     Browser


*** Variables ***
${URL}   https://www.alza.cz/
${URL_success}   https://www.alza.cz/?loginSuccess=1

*** Test Cases ***

Přihlášení špatný login
    Login         nesmysl@ale.cz         nevim
    Uživatel není přihlášen


Přihlášení špatné heslo
    Login         wavif64820@darkse.com    zapomnelajsem
    Uživatel není přihlášen


Přihlášení úspěšné
    Login      wavif64820@darkse.com      Nezname246
    Uživatel je přihlášen

Odhlášení
    Login      wavif64820@darkse.com      Nezname246
    Click      "Moje Alza"
    Get Text    "Odhlásit se"

*** Keywords ***
Login
    [Arguments]        ${email}     ${heslo}
    
    log  ${email}
    log  ${heslo}
    
    New Browser        chromium     headless=false
    New Page           https://www.alza.cz/
    Get Title          *=  Alza.cz
    Click              "Rozumím"
    Click              "Přihlásit se"
    Type Text          xpath=//*[@id="userName"]      ${email}
    Type Text          id=password     ${heslo}
    Click              "Přihlásit se"


Uživatel není přihlášen
       Get Text   "Neplatné uživatelské jméno nebo heslo"           # AssertNeg1
       Get Url                               !=    ${URL}             # AssertNeg2
       Take Screenshot

Uživatel je přihlášen
       Get url     ==   ${URL_success}
       Take Screenshot

Uživatel je odhlášen
        Get text   "Přihlásit se"