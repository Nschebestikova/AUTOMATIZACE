*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses
${email1}   negativni@test.kravina
${heslo1}   neprojde
${email2}   radek.tester@seznam.cz
${heslo2}   toasitezko
${email3}   giyipem264@v1zw.com
${heslo3}   tajnenovak

*** Test Cases ***
Prihlaseni bad login
    Login              ${email1}      ${heslo1}
    Uzivatel neni prihlasen

Prihlaseni bad heslo
    Login              ${email2}      ${heslo2}
    Uzivatel neni prihlasen

Prihlaseni success
    Login              ${email3}      ${heslo3}
    Uzivatel je prihlasen

*** Keywords ***
# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${email}      ${heslo}
    log             ${email}
    log             ${heslo}

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
       Get Text   data-test=logout_button    ==    Odhlásit se
       # je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně.
       Get Url                               ==    ${URL}


Uzivatel neni prihlasen
       Get Text   data-test=login_link       ==    Přihlásit se
       Get Url                               !=    ${URL}
