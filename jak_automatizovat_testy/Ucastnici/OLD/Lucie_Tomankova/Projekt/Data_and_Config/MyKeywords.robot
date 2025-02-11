*** Settings ***
Library         Browser
Resource        Configuration.robot
Resource        TestData.robot

*** Keywords ***
Open the browser, set geolocation and accept all cookies
    New Browser        headless=false
    ${permissions} =   Create List    geolocation   # vytvoří seznam co je povoleno (v tomto případě zjištění polohy)
    New Context        viewport={'width': 1920, 'height': 1080}    permissions=${permissions}   # záznam, rozlišení, povolení zjištování polohy
    Set Geolocation    50.0859772  14.4083842  3    # zadá prohlížeči polohu: Praha - Kampa
    New Page                ${URL}
    Set Browser Timeout     ${TIMEOUT_BROWSER}
    #test if it was ok
    ${text}    Get Title      ==    ${TITLE}
    Should Be Equal    ${text}     ${TITLE}
    #accepting all cookies
    Click                   ${COOKIES}
    Take Screenshot

Before each test
    New Page                ${URL}
    Go To                   ${URL}

Login
    [Arguments]     ${email}      ${password}
    #click the login button
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    Click                   ${SEL_LOGIN-BTN}
    Take Screenshot
    #type email and password
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    Type Text               ${SEL_LOGIN_EMAIL}        ${email}
    Type Text               ${SEL_LOGIN_PASSWORD}     ${password}
    #confirm login
    Click                   ${SEL_CONFIRM-LOGIN}

Check that the login was successful
    [Arguments]     ${valid}
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    #click the logout icon
    Click                   ${SEL_LOGOUT-ICON}
    #check if the login was successful
    ${valid} =     Get Text        ${SEL_CHECK_VALID_LOGIN}        ==      ${CHECK_VALID_LOGIN}
    #click the logout icon again, to close the pop up
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    Click                   ${SEL_LOGOUT-ICON}

Check that the login was unsuccessful
    [Arguments]     ${invalid}
    ${invalid} =     Get Text        ${SEL_CHECK_INVALID_LOGIN}        ==      ${CHECK_INVALID_LOGIN}

Logout
    #click the logout icon
    Click                   ${SEL_LOGOUT-ICON}
    #click the logout button
    Click                   ${SEL_LOGOUT-BTN}

Check that the logout was successful
    [Arguments]     ${logout_check}
    ${logout_check} =       Get Text        ${SEL_CHECK_VALID_LOGOUT}      ==      ${CHECK_VALID_LOGOUT}
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    Take Screenshot

Before shopping, make sure the basket is empty
    New Page                ${URL}    # pro stabilitu vše dělá v novém tabu
    Go to                   ${URL_CART}
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}

    #je košik prázdný?
    ${cart_overview_text}   Get Text                ${SEL_CartReview}
    Log                     ${cart_overview_text}

    #pokud ne vysypat nákupní koš
    Run Keyword If          '${TEXT_EmptyCart}' in '''${cart_overview_text}'''       Click               text="${TEXT_EmptyCart}"
    Take Screenshot

Add to the basket
    [Arguments]     ${type_item}       ${sel_item}
    #looking for items
    Type Text               ${SEL_GLOBAL_SEARCH}    ${type_item}
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    Click                   ${sel_item}

Closing the dialog box asking where to bring the products
    Set Browser Timeout     ${TIMEOUT_WAITING_FOR_DIALOG_BOX_TO_APPEAR}
    Click                   ${SEL_CLOSE_DIALOG_BOX}

Check that the items were added successfully
    Go To       ${URL}
    Get Text                ${SEL_HEADER_PRICE}   not contains   ${BASKET_VALUE}
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    Take Screenshot

Empty the basket
    #Caution: the keyword 'Remove one item from the basket' must be applied first
    Click                   ${SEL_HEADER_PRICE}
    Set Browser Timeout     ${TIME_BETWEEN_CLICKS}
    Click                   ${SEL_EMPTY_BASKET}
    #check if all the items were deleted successfully
    Get Text                ${SEL_PRICE_IN_BASKET}   contains   ${BASKET_VALUE}
    Take Screenshot

Non-existing item
    [Arguments]     ${non-existing}
    Login                                       ${VALID_EMAIL}          ${VALID_PASSWORD}
    Check that the login was successful         ${CHECK_VALID_LOGIN}
    ${non-existing} =       Type Text           ${SEL_GLOBAL_SEARCH}    ${NON-EXISTING-ITEM_1}
    Get Text        ${SEL_ERROR}       contains       ${ERROR_TEXT}
    Take Screenshot

Remove one item from the basket
    [Arguments]    ${sel_remove}
    Login                                       ${VALID_EMAIL}          ${VALID_PASSWORD}
    Check that the login was successful         ${CHECK_VALID_LOGIN}
    Before shopping, make sure the basket is empty
    Add to the basket                           ${ITEM_1}               ${SEL_ITEM_1}
    Add to the basket                           ${ITEM_2}               ${SEL_ITEM_2}
    Closing the dialog box asking where to bring the products
    Add to the basket                           ${ITEM_3}               ${SEL_ITEM_3}
    Closing the dialog box asking where to bring the products
    ${sel_remove} =     Click     ${SEL_REMOVE_ITEM_3}
    Take Screenshot

Close it all
    Close Browser
