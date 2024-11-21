*** Settings ***
Library  Browser

*** Variables ***
${USER1_NAME}           Michal Novák
${USER1_EMAIL}          giyipem264@v1zw.com
${USER1_PASSWORD}       tajnenovak
${LOGOUT_TEXT}          Odhlásit se

*** Test Cases ***
Test -Starting a browser with a page        #vcetne loginu
    New Browser             chromium                          headless=false
    New Page                http://testovani.kitner.cz/login

    Get Title               ==                               Testování - přihlášení

    # ${titulek} =            Get Title
    # Should Be Equal         ${titulek}                                  Swag Labs
    # Get Title               ==                                          Swag Labs

    Type Text               data-test=email_input              ${USER1_EMAIL}          #LOKATOR
    Type Text               data-test=password_input           ${USER1_PASSWORD}
    Take Screenshot
    click                   data-test=login_button

    ${text}     Get Text       data-test=logout_button
    Should Contain    ${text}  ${LOGOUT_TEXT}

    #Get Text                    ==                              ${LOGOUT_TEXT}

    Log To Console    ${text}
    Log               ${text}
#    ${text}                 =       Get Text    id=important    ==    Important text    # Returns element text with assertion.

    sleep                   3s
    Take Screenshot
    sleep                   10s

