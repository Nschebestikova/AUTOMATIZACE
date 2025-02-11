*** Settings ***
Library  Browser

*** Variables ***
${URL}                  https://www.rohlik.cz/
${corr_user_name}       devopor490@horsgit.com
${corr_password}        devopor490@
${incorr_user_name}     gblabla@bla.com
${incorr_password}      incorrblablapass

*** Test Cases ***
Přihlášení/kontrola/odhlášení - správné přihlašovací údaje
    Login       ${corr_user_name}            ${corr_password}       positive
    Logout

Přihlášení/přidání položky do košíku/odhlášení - správné přihlašovací údaje
    Login       ${corr_user_name}            ${corr_password}       positive
    Sleep       5
    Scroll By   ${None}   1000  0  auto
    Add to Cart
    Logout

Přihlášení/kontrola - chybné přihlašovací údaje
    Login           ${incorr_user_name}            ${incorr_password}       negative

Přihlášení/kontrola - neplatný formát emailu - chybí zavináč @
    Login           aaa.bbb.cz                     ${incorr_password}       negative
    Get Invalid Email Message

Přihlášení/kontrola - neplatný formát emailu - chybí začátek před @
    Login           @b.c                           ${incorr_password}       negative
    Get Invalid Email Message

Přihlášení/kontrola - neplatný formát emailu - chybí doména za @
    Login           a@.c                           ${incorr_password}       negative
    Get Invalid Email Message

Přihlášení/kontrola - neplatný formát emailu - chybí doménová koncovka
    Login           a@b.                           ${incorr_password}       negative
    Get Invalid Email Message

Přihlášení/kontrola - správné uživatelské jméno, prázdné heslo
    Login           ${corr_user_name}       ${empty}       negative
    Get Missing Password Message

Přihlášení/kontrola - prázdné uživatelské jméno a prázdné heslo
    Login           ${empty}     ${empty}      negative
    Get Missing Email Message
    Get Missing Password Message

Přihlášení/kontrola - prázdné uživatelské jméno, správné heslo
    Login           ${empty}     ${corr_password}       negative
    Get Missing Email Message


*** Keywords ***
Login
    [Arguments]     ${pemail}      ${pheslo}        ${test_type}
    log             ${pemail}
    log             ${pheslo}
    log             ${test_type}

    New Browser    chromium    headless=false
    ${permissions} =   Create List    geolocation
    New Context    permissions=${permissions}  viewport={"width": 1920, "height": 1080}
    Set Geolocation    50.0859772  14.4083842  3
    New Page       ${URL}
    Get Title      contains            Online supermarket Rohlik.cz
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click          data-test=header-user-icon
    Sleep          1
    Type Text      id=email          ${pemail}
    Sleep          1
    Type Text      id=password       ${pheslo}
    Sleep          1
    Click          data-test=btnSignIn
    Sleep          1
    IF    "${test_type}" == "positive"
          Get Text    data-test=header-user-icon  ==  JT
    ELSE
          Get Text    data-test=header-user-icon  ==  Účet
    END

Add to Cart
    Set Strict Mode    off
    Click       data-test=btnAdd
    Sleep  5
    Set Strict Mode    on
    ${close_button_state} =  Get Element States  css=[data-test=modal-close-button] [data-test=IconCloseX]
    Run Keyword If    'visible' in ${close_button_state} and 'enabled' in ${close_button_state}  Click  css=[data-test=modal-close-button] [data-test=IconCloseX]
    Click       data-test=cart
    Get Text    data-test=cart-redirectToCart  ==  K objednávce

Logout
    Click       data-test=header-user-icon
    Click       data-test=user-box-logout-button
    Get Text    data-test=header-user-icon  ==  Účet

Get Invalid Email Message
    Get Text    css=[data-test=user-login-form-email] [data-test=validation-message]  *=  Zadejte platný email

Get Missing Email Message
    Get Text    css=[data-test=user-login-form-email] [data-test=validation-message]  *=  Email je povinný

Get Missing Password Message
    Get Text    css=[data-test=user-login-form-password] [data-test=validation-message]  *=  Heslo je povinné


