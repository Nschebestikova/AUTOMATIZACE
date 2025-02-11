*** Settings ***
Library  Browser
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page       https://www.saucedemo.com/

    Get Title      ==    Swag Labs

#    <input class="input_error form_input" placeholder="Username" type="text" data-test="username" id="user-name" name="user-name" autocorrect="off" autocapitalize="none" value="">
#     Type Text      id=user-name   standard_user
    Type Text      data-test=username   standard_user
    Type Text      data-test=password   secret_sauce
    Click          data-test=login-button

    Get Text        css=[class="header_label"]  ==  Swag Labs
    Get Text        id=react-burger-menu-btn  ==  Open Menu
    Get Text        css=[class="login_credentials_wrap-inner"]

    Take Screenshot

    sleep          3

