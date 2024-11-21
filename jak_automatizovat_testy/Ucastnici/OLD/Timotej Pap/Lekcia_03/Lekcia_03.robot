*** Settings ***
Library  Browser

*** Variables ***
${USER1_NAME}               Michal Novák
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak


*** Test Cases ***
Starting a browser with a page
    New Browser         chromium      headless=false
    New Page            https://www.saucedemo.com/

    ${titulok} =        Get Title
    Should Be Equal     ${titulok}    Swag Labs  # jedna moznost
    Get Title           contains      Swag       # druha moznost
    Get Title           ==            Swag Labs  # tretia moznost
    Get Title           !=            Ahoj

    Type Text           data-test=username    Timotej
#   Click               "Login"
    Click               id=login-button

    Take Screenshot
    Sleep               5

Kitner prihlasenie
    New Browser         chromium      headless=false
    New Page            http://testovani.kitner.cz/login
    Get Title           contains      Testování

    Type Text           data-test=email_input      ${USER1_EMAIL}
    Type Text           data-test=password_input   ${USER1_PASSWORD}
    Click               id=login_button
    Get Text            data-test=courses_profile
    Sleep               3