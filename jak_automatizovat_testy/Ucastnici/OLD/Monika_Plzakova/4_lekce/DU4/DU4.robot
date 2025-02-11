*** Settings ***
Library     Browser

*** Variables ***
${test_page}        https://www.rohlik.cz/vitejte?gad_source=1&gclid=CjwKCAiAg9urBhB_EiwAgw88mZUCTZo1P4Nr2CVSmNClZafmC8ZPxxj10b6c3NCRUZCXNqi_zpwiqxoC3voQAvD_BwE

*** Test Cases ***
Test_Login_Positive
    Login_with_control          foniplz@seznam.cz    HesloHeslo11   yes

Test_Login_Negative
    Login_with_control          foniplz@seznam.cz    HesloHeslo1    no

Test_LogOut_Positive
    Logout                      foniplz@seznam.cz    HesloHeslo11   yes

Test_LogOut_Negative
    Logout                      foniplz@seznam.cz    HesloHeslo11   no

Test_Adding_to_cart_positive
    Adding_product_to_cart      foniplz@seznam.cz    HesloHeslo11   yes

Test_Adding_to_cart_negative
    Adding_product_to_cart      foniplz@seznam.cz    HesloHeslo11   no
*** Keywords ***
Login
    [Arguments]     ${username}     ${password}

    New Browser     chromium                        headless=false
    New Page        ${test_page}

    Click           data-test=header-user-icon
    Type Text       id=email                        ${username}
    Type Text       id=password                     ${password}
    Click           data-test=btnSignIn

Login_with_control
    [Arguments]     ${username}     ${password}     ${loggedIn}

    Login           ${username}     ${password}

    IF    "${loggedin}" == "yes"
        Get Element    data-test=notification-bell
    ELSE
         Get Element   id=email
    END

Logout
    [Arguments]     ${username}     ${password}     ${loggedout}

    Login           ${username}     ${password}

    IF    "${loggedout}" == "yes"
        Click           id=headerUser
        Click           data-test=user-box-logout-button
        Get Element     data-test=header-user-icon
    ELSE
        Click           id=headerUser
        Click           data-test=my-account-button
        Get Element     data-test=notification-bell
    END

Adding_product_to_cart
    [Arguments]      ${username}    ${password}    ${addToCart}

    Login    ${username}    ${password}

    IF    "${addToCart}" == "yes"
        ${old_mode} =      Set Strict Mode    False
        Click          css=[data-test=product-1] [data-test=counter]
        Set Strict Mode    ${old_mode}

        Click          data-test=cart-header
        Get Element    data-test=cart-redirectToCart
    ELSE
        Click          data-test=cart-header
        Get Element    data-test=shopping-lists
    END
