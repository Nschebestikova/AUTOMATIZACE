*** Settings ***
Library    Browser      timeout=40s
Documentation    Testing login and logout on Rohlik.cz webpage, adding items to the basket, and removing them from the basket.


*** Variables ***
${URL} =            https://www.rohlik.cz/vitejte
${TITLE} =        Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
${COOKIES} =        id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_LOGIN-BTN} =       css=[class="sc-c54407f5-0 ktYUOF"]
${SEL_CONFIRM-LOGIN} =        css=[class="sc-33d19302-0 jpkyuK"]
${SEL_LOGOUT-ICON} =        css=[class="sc-c54407f5-6 gYYdTT"]
${SEL_LOGOUT-BTN} =         css=.logOut.u-cursorPointer
${URL_CARROT} =         https://www.rohlik.cz/hledat?q=mrkev&companyId=1
${URL_BANANA} =         https://www.rohlik.cz/hledat?q=Banan&companyId=1


*** Test Cases ***
Login to rohlik.cz with valid credentials - Positive
    Login        lucispucis89@gmail.com      Testing.333
    Successful Login         Odhlásit se

Login to rohlik.cz with an invalid password - Negative
    Login        lucispucis89@gmail.com      Testing.3355
    Unsuccessful Login    Zadal(a) jste nesprávný e-mail nebo heslo.

Login to rohlik.cz with an invalid email - Negative
    Login        lucispucis89@gmail.cz      Testing.333
    Unsuccessful Login    Zadal(a) jste nesprávný e-mail nebo heslo.

Logout from rohlik.cz - Positive
    Login        lucispucis89@gmail.com      Testing.333
    Successful Login         Odhlásit se
    Logout

Adding and removing items from the basket - Positive
    Login        lucispucis89@gmail.com      Testing.333
    Successful Login         Odhlásit se
    Add to the basket       ${URL_CARROT}
    Add to the basket       ${URL_BANANA}
    Remove one item from the basket
    Delete All Items From The Basket


*** Keywords ***
Login
    [Arguments]     ${email}      ${password}
    #opening the browser and the webpage
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    #test if it was ok
    Sleep    5s
    ${text}    Get Title      ==    ${TITLE}
    Should Be Equal    ${text}     ${TITLE}
    Take Screenshot
    #allowing all cookies
    Click       ${COOKIES}
    #test if it was ok
    Take Screenshot
    #click the login button
    Click       ${SEL_LOGIN-BTN}
    #type email and password
    Type Text      id=email    ${email}
    Type Text      id=password     ${password}
    #confirm login
    Click       ${SEL_CONFIRM-LOGIN}

Logout
    #Caution: must be used together with the keywords 'Login' and 'Successful login'
    #click the logout button
    Click          ${SEL_LOGOUT-BTN}
    #check if the logout was successful
    Get Text        css=[class="sc-33d19302-0 gLxZbZ"]      ==      Účet
    Sleep    3s
    Take Screenshot

Successful login
    [Arguments]     ${valid}
    #click the logout icon
    Click          ${SEL_LOGOUT-ICON}
    #check if the login was successful
    ${valid} =     Get Text        data-test=user-box-logout-button        ==      Odhlásit se

Unsuccessful login
    [Arguments]     ${invalid}
    #check if the login was unsuccessful
    ${invalid} =     Get Text        data-test=notification-content        ==      Zadal(a) jste nesprávný e-mail nebo heslo.

Add to the basket
    [Arguments]     ${item}
    #go to item's url
    Go To       ${item}
    Sleep       6
    #selecting specific items
    Click       text="Do košíku" >> nth=2
    Click       text="Do košíku" >> nth=5
    #closing the dialog window asking where to bring the products
    Click       css=[class="modal-close-class"][data-test="IconCloseX"]
    #check if the items were added successfully
    ${emptyBasket} =    Get Text       data-test=headerPrice   contains   Kč
    Should Not Contain    ${emptyBasket}    0,00
    Take Screenshot

Remove one item from the basket
    Click     css=[class="sc-c57c261e-3 hHYQbz"]
    Click     data-test=IconMinus >> nth=1

Delete all items from the basket
    #Caution: the keyword 'Remove one item from the basket' must be applied first
    Click     css=[class="clearCart"]
    #check if all the items were deleted successfully
    ${test} =   Get Text       data-test=cs-price   contains   0,00
    Take Screenshot