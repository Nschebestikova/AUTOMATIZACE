*** Settings ***
Library     Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    #New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.saucedemo.com/

    Get Title      ==    Swag Labs          #overeni nactene stranky

#   <input class="input_error form_input" placeholder="Username" type="text" data-test="username" id="user-name" name="user-name" autocorrect="off" autocapitalize="none" value="">
#   Type Text      id=user-name   standard_user
    Type Text      data-test=username   standard_user           #prihlaseni jmena
    Type Text      data-test=password   secret_sauce            #prihlaseni hesla
    click          data-test=login-button

    Get text          css=[class="header_label"]   ==  Swag Labs
    Get Text          css=[id="menu_button_container"]     ==
    Take Screenshot   fullPage=True    fileType=jpeg    quality=50    timeout=10s
#   Vyhledání černého boxu
    Get text       css=[class="login_credentials_wrap-inner"]   ==



#   Type Text    id=searchGlobal     Ahoj

#    Click   xpath=//*[@id="searchForm"]/button
#    sleep   5

#   ${selector} =    Record Selector   tlačítko
#   Click  ${selector}






































#
#
#
#rohlik
#    New Browser    Chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://rohlik.cz
#
#    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
#
#
#
##   Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
##   Click           text="Allow all"
##   Click           "Allow all"
##   Click           xpath=//*[@id="CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll"]
#    Click           css=CybotCookiebotDialogBodyButton
#   Sleep           3
#   Click           data-test=delivery-times
#
#   Sleep            30
#   Take Screenshot
#
#
#
#
#
#
#
##    # Na rohlíku je aktuálně problém, že strnka po potvrzení Cookies problikne a tím se stratí kliknutí na login
 ##    # poroto je nutné ověřit otveření přihlašovacího okna
 ###    ${nevim} =  Get Text            text=Přihlášení
 ##    ${je_otevreno_prihlaseni} =  Get Element Count    text=Přihlášení
 ##    Log                 ${je_otevreno_prihlaseni}
 ##    IF  ${je_otevreno_prihlaseni} == 0
 ##        sleep  1
 ##        Click               id=headerLogin
 ##    END
#
#
#
#
#
#















