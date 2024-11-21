*** Settings ***
Library     Browser
Resource    Data/TestData.robot
Resource    Data/Konfigurace.robot

Suite Setup      Suit_Setup
Suite Teardown   Suit_Teardown

Test Setup      Test_Setup
Test Teardown   Test_Teardown

*** Test Cases ***
Test_Login_Positive
    Login_with_control          ${user1_email}    ${user1_password}    yes
    Logout

Test_Login_Negative
    Login_with_control          ${user1_email}    HesloHeslo1    no

Test_LogOut_Positive
    Logout_with_control         ${user1_email}    ${user1_password}    yes
    Logout

Test_LogOut_Negative
    Logout_with_control         ${user1_email}    ${user1_password}    no
    Logout

Test_Adding_to_cart_positive
    Adding_product_to_cart      ${user1_email}    ${user1_password}    yes
    Logout

Test_Adding_to_cart_negative
    Adding_product_to_cart      ${user1_email}    ${user1_password}    no
    Logout

*** Keywords ***
Login
    [Arguments]     ${username}     ${password}

#    New Browser     ${test_browser}                 headless=false
#    New Page        ${testpage}

    Click           ${sel_LoginAccountBtn}
    Type Text       ${sel_EmailInput}               ${username}
    Type Text       ${sel_PwdInput}                 ${password}
    Click           ${sel_LoginBtn}

Logout
    Click    ${sel_UserBtn}
    Click    ${sel_LogoutBtn}

Login_with_control
    [Arguments]     ${username}     ${password}     ${loggedIn}

    Login           ${username}     ${password}

    IF    "${loggedin}" == "yes"
        Get Element    ${sel_NotificationBtn}
    ELSE
         Get Element   ${sel_EmailInput}
    END

Logout_with_control
    [Arguments]     ${username}     ${password}     ${loggedout}

    Login           ${username}     ${password}
    
    Sleep    2

    IF    "${loggedout}" == "yes"
        Click           ${sel_UserBtn}
        Click           ${sel_NotificationBtn}
        Get Element     ${sel_LoginAccountBtn}
    ELSE
        Click           ${sel_UserBtn}
        Click           ${sel_UserInfoBtn}
        Get Element     ${sel_NotificationBtn}
    END

Adding_product_to_cart
    [Arguments]      ${username}    ${password}    ${addToCart}

    Login    ${username}    ${password}
    
    Sleep    2

    IF    "${addToCart}" == "yes"
        ${old_mode} =      Set Strict Mode    False
        Scroll To Element       ${sel_ProductListTitle}
        Click                   css=[data-test=product-1] [data-test=counter]
        Set Strict Mode         ${old_mode}

        Click          ${sel_CartBtn}
        Get Element    ${sel_ToTheCartBtn}
    ELSE
        Click          ${sel_CartBtn}
        Get Element    ${sel_CreateShoppingListBtn}
    END

Suit_Setup
    New Browser        ${test_browser}       headless=False
    New Page           ${testpage}

    Click              id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

Suit_Teardown
    Close Browser

Test_Setup
    Go To    ${testpage}

Test_Teardown
    Go To    ${testpage}