*** Settings ***
Library     Browser

*** Variables ***
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak

*** Keywords ***
Browser Settings
    New Browser        chromium    headless=false
    New Page       http://testovani.kitner.cz/login


Login
    [Arguments]     ${USER1_EMAIL}       ${USER1_PASSWORD}
    log             ${USER1_EMAIL}
    log             ${USER1_PASSWORD}
    Type Text       data-test=email_input   ${USER1_EMAIL}
    Type Text       data-test=password_input    ${USER1_PASSWORD}
    Click           data-test=login_button


Ověření Nepřihlášení
    Get Text        data-test=login_text  ==  Přihlášení

Přihlášeni
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


*** Test Cases ***

Prihlaseni pozitivní test
    Browser Settings
    Login              martina.stolbova@seznam.cz              Heslo123
    Uzivatel je prihlasen
    Odhlaseni

Negativní přihlášení
    Browser Settings
    Get Text           data-test=login_text  ==  Přihlášení
    Login              martina.stolbova@seznam.cz              heslo123
    Sleep              3
    Uzivatel je odhlasen










