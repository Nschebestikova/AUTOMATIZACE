
*** Settings ***
Library   Browser

*** Variables ***
${url}     https://www.alza.cz/
${login}   nikolaschebestikova@gmail.com
${heslo}   Testerka123
#${URLovereni}

*** Test Cases ***
Otevření prohlížeče
    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      *=  Alza.cz
    Click          "Rozumím"
    Click          "Přihlásit se"
    Type Text      id=    ${login}
    Type Text      id=password     ${heslo}
    Click          "Přihlásit se"


Uživatel není přihlášen
       Get Text   "Neplatné uživatelské jméno nebo heslo"
       Get Url      !=    ${URL}
       Take Screenshot

Uživatel je přihlášen
       Get url     ==   ${}
       Take Screenshot

Uživatel je odhlášen
        Get text   "Přihlásit se"