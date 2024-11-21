*** Settings ***
Library    Browser

*** Variables ***
${USER1_NAME}               Michal Novák
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak
${URL}                      http://testovani.kitner.cz/login

*** Test Cases ***
# Bez Keywords
Test_ukol
    New Browser     chromium  headless=false
    New Page        ${URL}

    Get Title       contains    Testování

    Type Text       data-test=email_input      ${USER1_EMAIL}
    Type Text       data-test=password_input   ${USER1_PASSWORD}
# Dalsi moznosti nalezeni elementu:
#   Type Text       xpath=//*[@id="email_input"]
#   Type Text       id=email_input
#   Type Text       class=input_box email border-[#E9EDF4] focus:border-[#bec0c2]w-full rounded-md border bg-whitepy-3 px-5 text-base text-body-colorplaceholder-[#ACB6BE] outline-nonefocus:border-primary focus-visible:shadow-none" value="">

    Click           id=login_button
    Sleep           5

    GetText         text="Odhlásit se"  ==  Odhlásit se
    Take Screenshot

    Click           data-test=logout_button
    Sleep           5

    GetText         text="Přihlásit se"  ==  Přihlásit se
    Take Screenshot

# Vcetne Keywords
Test_keywords
    New Browser     chromium  headless=false
    New Page        ${URL}

    Login           ${USER1_EMAIL}        ${USER1_PASSWORD}
    Take Screenshot
    Sleep           5

*** Keywords ***
Login
    [Arguments]     ${email}     ${password}

    Type Text       data-test=email_input      ${email}
    Type Text       data-test=password_input   ${password}
    Click           data-test=login_button
    Sleep           5
    Click           data-test=logout_button
    Sleep           5

    Log             ${email}
    Log             ${password}