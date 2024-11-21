*** Settings ***
Library  Browser
Resource        Data_and_Config/Configuration.robot   #připojený externí soubor s konfiguračními parametry
Resource        Data_and_Config/TestData.robot   #připojený externí soubor s testovacími daty

Suite Setup     Pred_sadou
Test Setup      Pred_testem
#Test Teardown   Uklid_po_testu
Suite Teardown  Uklid_sada

*** Test Cases ***
Přihlášení/kontrola/odhlášení - správné přihlašovací údaje
    Login       ${corr_user_name}            ${corr_password}       positive
    Logout

Přihlášení/přidání položky do košíku/odhlášení - správné přihlašovací údaje
    Login       ${corr_user_name}            ${corr_password}       positive
    Scroll By   ${None}   1000  0  auto
    Add to Cart
    Logout

Přihlášení/kontrola - chybné přihlašovací údaje
    Login           ${incorr_user_name}                                ${incorr_password}       negative

Přihlášení/kontrola - neplatný formát emailu - chybí zavináč @
    Login           ${incorr_user_name_format_missing_at}              ${incorr_password}       negative
    Get Invalid Email Message

Přihlášení/kontrola - neplatný formát emailu - chybí začátek před @
    Login           ${incorr_user_name_format_missing_beginning}       ${incorr_password}       negative
    Get Invalid Email Message

Přihlášení/kontrola - neplatný formát emailu - chybí doména za @
    Login            ${incorr_user_name_format_missing_domain}         ${incorr_password}       negative
    Get Invalid Email Message

Přihlášení/kontrola - neplatný formát emailu - chybí doménová koncovka
    Login            ${incorr_user_name_format_missing_domain_end}     ${incorr_password}       negative
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
    Sleep           100ms
    ${cookie_button_state} =  Get Element States  ${SEL_CookiesDialogButtonAllowAll}
    Run Keyword If    'visible' in ${cookie_button_state} and 'enabled' in ${cookie_button_state}  Click  ${SEL_CookiesDialogButtonAllowAll}

    ${IconCloseX_state} =  Get Element States  ${SEL_IconCloseX_state}
    Run Keyword If    'visible' in ${IconCloseX_state} and 'enabled' in ${IconCloseX_state}  Click  ${SEL_IconCloseX_state}

    Click          ${SEL_HeaderUserIcon}
    Type Text      ${SEL_LoginFormEmail}          ${pemail}
    Type Text      ${SEL_LoginFormPwd}            ${pheslo}
    Click          ${SEL_LoginLink}
    IF    "${test_type}" == "positive"
          Get Text    ${SEL_HeaderUserIcon}  ==  ${TEXT_Uspesne_prihlaseny}
    ELSE
          Get Text    ${SEL_HeaderUserIcon}  ==  ${TEXT_Odhlaseny}
    END

Add to Cart
    Set Strict Mode    off
    Click       ${SEL_AddToCart}
    Sleep       1
    Set Strict Mode    on
    ${close_button_state} =  Get Element States  ${SEL_DeliveryMapCloseButton}
    Run Keyword If    'visible' in ${close_button_state} and 'enabled' in ${close_button_state}  Click  ${SEL_DeliveryMapCloseButton}
    Click       ${SEL_Cart}
    Get Text    ${SEL_RedirectToCart}   ==  ${TEXT_CartToOrder}

Clear Cart
   Click       ${SEL_HeaderMainLogo}
   Click       ${SEL_Cart}
   Sleep       1
   Scroll By   ${None}   1000  0  auto
   ${ClearCartButton_state} =  Get Element States  ${SEL_ClearCartButton}
   Run Keyword If    'visible' in ${ClearCartButton_state} and 'enabled' in ${ClearCartButton_state}  Click  ${SEL_ClearCartButton}

Logout
    Click       ${SEL_HeaderUserIcon}
    Click       ${SEL_LogoutButton}
    Get Text    ${SEL_HeaderUserIcon}  ==  ${TEXT_Odhlaseny}

Get Invalid Email Message
    Get Text    ${SEL_LoginInvalidEmailMessage}  *=  ${ERROR_TEXT_IncorrectEmail}

Get Missing Email Message
    Get Text    ${SEL_LoginMissingEmailMessage}  *=  ${ERROR_TEXT_MissingEmail}

Get Missing Password Message
    Get Text    ${SEL_LoginMissingPwd}  *=  ${ERROR_TEXT_MissingPassword}

Pred_sadou
   New Browser        chromium   headless=False
   ${permissions} =   Create List    geolocation
   New Context        permissions=${permissions}  viewport={"width": ${ResolutionWidth}, "height": ${ResolutionHeight}}
   Set Geolocation    ${GeoLatitude}  ${GeoLongitude}  ${GeoAccuracy}
   Set Browser Timeout    ${BrowserTimeout}
   New Page           ${URL}
   Get Title  *=      ${TEXT_MainTitle}

Pred_testem
   Go To              ${URL}
   Sleep              ${SleepBeforeTest}
   ${IconCloseX_state} =  Get Element States  ${SEL_IconCloseX_state}
   Run Keyword If    'visible' in ${IconCloseX_state} and 'enabled' in ${IconCloseX_state}  Click  ${SEL_IconCloseX_state}

Uklid_sada
   ${IconCloseX_state} =  Get Element States  ${SEL_IconCloseX_state}
   Run Keyword If    'visible' in ${IconCloseX_state} and 'enabled' in ${IconCloseX_state}  Click  ${SEL_IconCloseX_state}
   Login       ${corr_user_name}            ${corr_password}       positive
   Clear Cart
   Close Browser
