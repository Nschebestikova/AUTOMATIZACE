*** Settings ***
Library     Browser

*** Variables ***

${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak

*** Test Cases ***

Prihlaseni a odhlaseni kitner.cz

# přihlášení
    New Browser     chromium        headless=false
    New Page        http://testovani.kitner.cz/login
    Prihlaseni      giyipem264@v1zw.com    tajnenovak
    Uzivatel je prihlasen

# odhlášení
    Odhlaseni
    Uzivatel je odhlasen


*** Keywords ***

Prihlaseni
    [Arguments]     ${USER1_EMAIL}       ${USER1_PASSWORD}
    Type Text       data-test=email_input                   ${USER1_EMAIL}
    Type Text       data-testid=password_input              ${USER1_PASSWORD}
    Click           id=login_button

Odhlaseni
    Click           text=Odhlásit se

Uzivatel je prihlasen
    Get Text        data-testid=logout_button       ==      Odhlásit se
    Log             Uživatel je přihlášen

Uzivatel je odhlasen
    Get Text        data-testid=login_link         ==      Přihlásit se
    Log             Uživatel je odhlašen
