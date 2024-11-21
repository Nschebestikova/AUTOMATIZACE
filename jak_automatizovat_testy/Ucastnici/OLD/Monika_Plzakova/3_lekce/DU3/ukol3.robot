*** Settings ***
Library     Browser

*** Variables ***
${test_page}        https://www.rohlik.cz/vitejte?gad_source=1&gclid=CjwKCAiAg9urBhB_EiwAgw88mZUCTZo1P4Nr2CVSmNClZafmC8ZPxxj10b6c3NCRUZCXNqi_zpwiqxoC3voQAvD_BwE

*** Test Cases ***
Test_Login/LogOut
    Login           foniplz@seznam.cz    HesloHeslo11

    Click           id=headerUser
    Click           text="Odhlásit se"

*** Keywords ***
Login
    [Arguments]     ${username}     ${password}
    [Documentation]     Provede prihlaseni do aplikace


    New Browser     chromium                        headless=false
    New Page        ${test_page}

    Click           data-test=header-user-icon
    Type Text       id=email                        ${username}
    Type Text       id=password                     ${password}
    Click           data-test=btnSignIn
