*** Settings ***
Library  Browser

*** Variables ***
# global vairable
${URL}      http://testovani.kitner.cz/courses

*** Test Cases ***
#Registrace s korektními udaji
Registrace - success
    Zadaní registrace       DomSie    dominik@sieber.com   tajnenovak    tajnenovak     Zaregistrovan
#Registrace s krátkym heslem
Registrace - fail - kratke pass
    Zadaní registrace       Radek    radek@radek.com       123           123            Nezaregistrovan
    Kratke pass
#Registrace s pouzitym mailem
Registrace - fail - email taken
    Zadaní registrace       Testik    dominik@sieber.com   tajnenovak    tajnenovak     Nezaregistrovan
    Email error
#Registrace se spatnym overenim hesla
Registrace - fail - spatne pass
    Zadaní registrace       RaSun    RaSun@RaSun.com       tajnenovak    tasjne         Nezaregistrovan
    Spatne pass

#Registrace s prazdnym udajem
Registrace - blank mail
    Zadaní registrace       RaTilt    ${EMPTY}              tajnenovak    tajnenovak      Nezaregistrovan
    Blank mail error

#Registrace - TBD

*** Keywords ***
Zadaní registrace
    [Arguments]     ${name}     ${email}    ${password}     ${pass_verific}    ${registered}
    Log             ${name}
    Log             ${email}
    Log             ${password}

    New Browser     chromium    headless=true
    New Context     viewport={'width': 1920, 'height': 1080}
    New Page        ${URL}
    Click           data-test=login_link
    Log             Login macknut
    Get Url         *=  login
    Log             Url obsahuje "kitner.cz/login"
    Click           data-test=register_link
    Get Url         *=  kitner.cz/register
    Log             Registracni form nacten
    Fill Text       data-test=name_input                ${name}
    Fill Text       data-test=email_input               ${email}
    Fill Text       data-test=password_input            ${password}
    Fill Text       data-test=password_again_input      ${pass_verific}
    Click           data-test=register_button
    Log             Kliknuto na registraci po vyplneni udaju!
    
    IF    "${registered}" == "Nezaregistrovan"
        Get Url     *=      kitner.cz/register
        Take Screenshot
    ELSE
        Get Text    data-test=home_section      ==      Vítej uživateli ${name}!
        Log         Domaci stranka
        Take Screenshot
    END

 Email error
    Get Text    data-test=email_input_errors      ==     The email has already been taken.
    Log         Email je jiz pouzit
    Take Screenshot

 Blank mail error
    Get Text    data-test=email_input_errors      ==      The email field is required.
    Log         Polozka email je povinne
    Take Screenshot

 Kratke pass
    Get Text    data-test=password_input_errors     ==      The password field must be at least 8 characters.
    Log         Heslo musí byt min 8 znaku
    Take Screenshot

 Spatne pass
    Get Text    data-test=password_input_errors     ==      The password field confirmation does not match.
    Log         Heslo nesouhlasi
    Take Screenshot