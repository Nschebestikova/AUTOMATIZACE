*** Settings ***
Library  Browser


*** Variables ***
${URL}              https://allegro.cz/prihlaseni?origin_url=%2F

*** Test Cases ***

Otevreni prohlizece
    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      ==    Allegro - Náš největší internetový obchod
    Get Text        css=[data-testid="homeViewActions"]
    Click           css=[data-testid="accept_home_view_action"]
    Click           text="Přihlásit se"

Spatne prihlaseni email
     Login              kaslovalia@gmail.com        Mb4jadj2$
     Click              text="Přihlásit se"

Spatne prihlaseni heslo
     Login              kasslovalia@gmail.com       llllllll$
     Click              text="Přihlásit se"

Spravne prihlaseni
     Login              kasslovalia@gmail.com       Mb4jadj2$
     Click              text="Přihlásit se"



*** Keywords ***
Login
    [Arguments]         ${email}                ${heslo}

    log                 ${email}
    log                 ${heslo}


