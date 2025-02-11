*** Settings ***
Library     Browser
Library     Screenshot


*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
#Testy na prihlaseni
Prihlaseni bad login
    Login               anonym@neseznam.cz                  tajnenovak
    Uzivatel neni prihlasen
Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              superduperheslo
    Uzivatel neni prihlasen
Prihlaseni success
    Login               giyipem264@v1zw.com                 tajnenovak
    Uzivatel je prihlasen

#Test na odhlaseni
Odhlaseni
    Login               giyipem264@v1zw.com                 tajnenovak
    Logout


*** Keywords ***
Login
    [Arguments]         ${email}        ${heslo}

    log                 ${email}
    log                 ${heslo}

    New Browser         chromium                    headless=false
    New Page            ${URL}
    Get Title           *=                          Testování
    Click               data-test=login_link
    Sleep               1
    Get Title           *=                          přihlášení
    Get Text            id=forgot_password_link
    Get Text            xpath=//*[@id="login_button"]
    Type Text           data-test=email_input       ${email}
    Type Text           data-test=password_input    ${heslo}
    Click               data-test=login_button

Uzivatel je prihlasen
    Get Text            data-test=logout_button     ==      Odhlásit se
    Get Url             ==                          ${URL}
    Screenshot.Take Screenshot


Uzivatel neni prihlasen
    Get Text         data-test=login_link           ==      Přihlásit se
    Get Url          !=                             ${URL}
    Screenshot.Take Screenshot

Logout
    Click            data-test=logout_button
    Get Url          ==                             ${URL}
    Get Text         data-test=login_link           ==      Přihlásit se
    Get Text         text=Přihlásit se
    Screenshot.Take Screenshot