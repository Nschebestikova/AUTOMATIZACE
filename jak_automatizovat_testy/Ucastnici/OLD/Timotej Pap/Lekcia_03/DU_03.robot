*** Settings ***
Library  Browser

*** Variables ***
${email}    giyipem264@v1zw.com
${heslo}    tajnenovak


*** Test Cases ***
Prihlasenie, odhlasenie Kitner s kontrolou
    New Browser         headless=False
    New Page            http://testovani.kitner.cz/courses
    Get Title           contains     Testování - Přehled kurzů
    Login               ${email}    ${heslo}
    Get Text            data-test=logout_button
    Logout
    Take Screenshot

*** Keywords ***
Login
    [Arguments]         ${email}    ${heslo}
    Click               data-test=login_link
    Type Text           id=email_input                   ${email}
    Type Text           id=password_input                ${heslo}
    Click               data-test=login_button
    Take Screenshot
    log                 ${email}
    log                 ${heslo}
Logout
    Click               data-test=logout_button
    Get Text            data-test=login_link