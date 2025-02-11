*** Settings ***
Library    Browser
Documentation   Testing login and logout to rohlik.cz application. Testing more possible selectors. Creating a keyword for login and logout, so that the test can be used universally for both, positive and negative scenarios. Plus making the code more reusable/easier to editable with variables.


*** Variables ***
${URL} =            https://www.rohlik.cz/vitejte
${TITLE} =        Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
${COOKIES} =        id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${LOGIN-BTN} =       css=[class="sc-c54407f5-0 ktYUOF"]
${LOGINFORM-S} =        css=.sc-79aed818-0.bCtrkG.u-mb--8
${LOGINFORM-T} =          Přihlášení
${CONFIRM-LOGIN} =        css=[class="sc-33d19302-0 jpkyuK"]
${LOGOUT-ICON} =        css=[class="sc-c54407f5-6 gYYdTT"]
${LOGOUTFORM-S} =       css=.logOut.u-cursorPointer
${LOGOUTFORM-T} =       Odhlásit se
${LOGOUT-BTN} =         css=.logOut.u-cursorPointer
${CHECK-AFTER-LOGOUT-ICON-S} =      css=.sc-33d19302-0.gLxZbZ
${CHECK-AFTER-LOGOUT-ICON-T} =      Účet


*** Test Cases ***
Login and logout to rohlik.cz with valid credentials
    Login and logout        lucispucis89@gmail.com      Testing.333      Přihlášení     Účet
Login and logout to rohlik.cz with an invalid email
    Login and logout        lucispucis89@gmail.cz      Testing.333      Přihlášení     Účet
Login and logout to rohlik.cz with an invalid password
    Login and logout        lucispucis89@gmail.com      Testing.555      Přihlášení     Účet


*** Keywords ***
Login and logout
    [Arguments]     ${email}      ${password}     ${checkLogin}     ${checkLogout}
    #opening the browser and the webpage
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    #test if it was ok
    Sleep    3s
    ${text}    Get Title      ==    ${TITLE}
    Should Be Equal    ${text}     ${TITLE}
    Take Screenshot

    #allowing all cookies
    Click       ${COOKIES}
    #test if it was ok
    Take Screenshot

    #click the login button
    Click       ${LOGIN-BTN}
    #test if it was ok
    Get Text        ${LOGINFORM-S}        ==      ${LOGINFORM-T}
    Take Screenshot

    #type email and password
    Type Text      id=email    ${email}
    Type Text      id=password     ${password}
    #test if it was ok
    ${checkLogin} =     Get Text        ${LOGINFORM-S}        ==      ${LOGINFORM-T}
    Take Screenshot

    #confirm login
    Click       ${CONFIRM-LOGIN}

    #click the logout icon
    Click          ${LOGOUT-ICON}
    #test if it was ok
    Sleep    3s
    Get Text       ${LOGOUTFORM-S}       ==      ${LOGOUTFORM-T}
    Take Screenshot

    #click the logout button
    Click          ${LOGOUT-BTN}
    #test if it was ok
    ${checkLogout} =        Get Text       ${CHECK-AFTER-LOGOUT-ICON-S}      ==      ${CHECK-AFTER-LOGOUT-ICON-T}
    Take Screenshot
