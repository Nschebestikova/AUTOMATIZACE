*** Settings ***
Library  Browser

*** Variables ***
${USER}         giyipem264@v1zw.com
${PASS}         tajnenovak
${BAD_USER}     radekkitner@gmail.com
${BAD_PASS}     kitnertajne
${URL}          http://testovani.kitner.cz/courses


*** Test Cases ***


# positive login, logout
Login, logout with check
    Set Strict Mode     off
    Server              ${URL}
    Login               ${USER}     ${PASS}
    Logout

# negative test username
Bad username with check
    Server              ${URL}
    Bad username        ${BAD_USER}     ${PASS}

# negative test password
Bad password with check
    Server              ${URL}
    Bad password        ${USER}         ${BAD_PASS}


*** Keywords ***
Server
    [Arguments]         ${URL}
    New Browser         headless=False
    New Page            ${URL}
    Get Title           contains    Testování

Login
    [Arguments]         ${USER}                     ${PASS}
    Get Element States  data-test=login_link
    Click               data-test=login_link
    Type Text           css=#email_input            ${USER}
    Type Text           id=password_input           ${PASS}
    Get Element States  data-test=login_button
    Click               data-test=login_button
    Take Screenshot
    log                 ${USER}
    log                 ${PASS}
    Get Text            text="Můj Profil"

Logout
    Click               data-test=logout_button
    Get Text            text="Přihlásit se"
    Take Screenshot

Bad username
    [Arguments]         ${BAD_USER}             ${PASS}
    Click               data-test=login_link
    Type Text           id=email_input          ${BAD_USER}
    Type Text           id=password_input       ${PASS}
    Click               data-test=login_button
    Get Text            text="Přihlásit se"
    Take Screenshot


Bad password
    [Arguments]         ${USER}                 ${BAD_PASS}
    Click               data-test=login_link
    Type Text           css=#email_input        ${USER}
    Type Text           id=password_input       ${BAD_PASS}
    Click               data-test=login_button
    Get Text            text="Přihlásit se"
    Take Screenshot
