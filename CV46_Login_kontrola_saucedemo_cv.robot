#  Přidáním negativního testu "Login chybne heslo" nefunguje správně KS Login,
#  jak jej opravíte aby mohlo být jen jedno KS pro pozitivní i negativní testy?
#  1. je třeba vymyslet co se bude kontrolovat?
#  2. je třeba upravit KS Login



*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.saucedemo.com/


*** Test Cases ***

Login
    Login               standard_user               secret_sauce                Add to cart

Login chybne heslo
    Login               standard_user               chyba                       Epic sadface: Username and password do not match any user in this service


*** Keywords ***

Login
    [Arguments]     ${user}      ${password}     ${outcome}

    log             ${user}
    log             ${password}
    log             ${outcome}


    New Browser     chromium                headless=false

    New Page        ${URL}

    Get Title       contains                Swag Labs

    Click           xpath=//*[@id="user-name"]

    Type Text       id=user-name            ${user}

    Click           data-test=password

    Type Text       id=password             ${password}

    Click           xpath=//*[@id="login-button"]

    # Tady je to třeba nějak vylepšit, ale jak? :)
    Get Text        id=add-to-cart-sauce-labs-backpack      ==        ${outcome}   # kontrola zda je na stránce tlačítko pro přidání do košíku
    #nebo
    #Get Text        data-test=error          ==                       ${outcome}  # kontrola zda při zadávání přihlašovacích údajů došlo k chybě

    Click           xpath=//*[@id="react-burger-menu-btn"]

    Get Text        id=logout_sidebar_link                  ==         Logout

    Click           id=logout_sidebar_link

    Get Text        id=login-button                         ==         Login



