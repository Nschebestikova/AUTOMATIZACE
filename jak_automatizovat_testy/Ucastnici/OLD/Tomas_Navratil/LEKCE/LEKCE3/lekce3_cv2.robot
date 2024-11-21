*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser             chromium                                    headless=false
#    New Context            viewport={'width': 1920, 'height': 1080}
    New Page                https://www.saucedemo.com/
    Get Title               ==                                          Swag Labs
    ${titulek} =            Get Title
    Should Be Equal         ${titulek}                                  Swag Labs
    Get Title               contains                                    Swag
    Get Title               !=                                          Ahoj

    Type Text               data-test=username                          Ahoj

  # Níže popsané 3 způsoby jednou jen pokud je vyplý strict mode a vybere 1. ze dvou variant
#    Type Text     css=.form_input                   standard_user   # výběr pomocí 1 class
#    Type Text     css=.input_error.form_input       standard_user   # výběr pomocí 2 class, nesmí mezi něma být mezera
#    Type Text     css=[class="input_error form_input"]   standard_user   #výběr pomocí 2 class formou css atributu
#   Click                   "Login"
 #   Click                    id=login-button
     Click                    css=[class="submit-button btn_action"]   # click pomoci class lokatoru css
 #   Take Screenshot     # Take Screenshot
     Sleep               3



