*** Settings ***
Library  Browser

*** Variables ***
${URL}          http://testovani.kitner.cz/login

*** Test Cases ***
Prihlaseni a odhlaseni success
    Login               giyipem264@v1zw.com            tajnenovak
    Get Text            data-test=logout_button   ==   Odhlásit se
    Click               data-test=logout_button
    Get Text            data-testid=login_link   ==    Přihlásit se

*** Keywords ***
Login
    [Arguments]     ${pemail}      ${pheslo}

    log             ${pemail}
    log             ${pheslo}

    New Browser    chromium    headless=false
    New Page       ${URL}

    Type Text      data-testid=email_input          ${pemail}    #použit lokátor data-testid

    Type Text      id=password_input          ${pheslo}     #použit lokátor id

    Sleep          2

    Click          data-testid=login_button


