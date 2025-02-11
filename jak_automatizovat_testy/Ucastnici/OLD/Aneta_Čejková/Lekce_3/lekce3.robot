#Zkouška, jestli fungujeme
# *** Settings ***
# Library    Browser

# *** Test Cases ***
# Starting a browser with a page
#     New Browser    chromium    headless=false
#     New Page    https://marketsquare.github.io/robotframework-browser/Browser.html
#     Get Title     ==     Browser

#Lekce3
# *** Settings ***
# Library  Browser

# *** Test Cases ***
# Starting a browser with a page
#     New Browser    chromium    headless=false
#     New Context    viewport={'width': 1920, 'height': 1080}
#     New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#     Get Title      ==    Browser

#Cvičení 1
*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page       https://www.saucedemo.com/

    Get Title      ==    Swag Labs

#    <input class="input_error form_input" placeholder="Username" type="text" data-test="username" id="user-name" name="user-name" autocorrect="off" autocapitalize="none" value="">
    
#Type Text      id=user-name   standard_user
    Type Text      data-test=username   problem_user
    Type Text    data-test=password    secret_sauce
    Click    data-test=login-button
    Get Text    css=[class="header_label"]  ==  Swag Labs  
    #Get Text    css=[class="inventory_item_name"]  ==  Sauce Labs Backpack  
    #Click        id=item_4_title_link
    sleep          3

xx