*** Settings ***
Library  Browser


*** Variables ***
${url}                   https://www.rohlik.cz/
${cookies}               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${ikona_prihlasit}       data-test=header-user-icon
${btn_prihlasit}         data-test=btnSignIn
${ikona_odhlasit}        id=headerUser
${btn_odhlasit}          data-test=user-box-logout-button
${negativni_hlaska}      Zadal(a) jste nesprávný e-mail nebo heslo.

*** Keywords ***

Browser Settings
    New Browser         chromium    headless=false
    New Page            ${url}
    Click               ${cookies}
    Get Text            data-test=logo-main
   # Click               ${ikona_prihlasit}
    Set Strict Mode     False
    Take Screenshot

Login
    [Arguments]         ${email}      ${heslo}
    Click               ${ikona_prihlasit}
    Type Text           id=email  ${email}
    Type Text           id=password  ${heslo}
    Click               ${btn_prihlasit}
    Take Screenshot

Logout
    Click               ${ikona_odhlasit}
    Click               ${btn_odhlasit}
    Get Text            data-test=button  ==  Účet
    Take Screenshot

Přidat do košíku
    [Arguments]          ${přidat_položku}
    Type Text            id=searchGlobal    ${přidat_položku}
    
    Click                (//*[@data-test="btnAdd"])[1]
    #Click                text="Do košíku" >> nth=1
    #Click                [data-product-id="1350963"] [aria-label="Přidat jeden kus."]

Zruš vyskakovací okno
    Click                data-test=modal-close-button 
    Click                data-test=logo-main

Odebrat z košíku
    [Arguments]          ${odstranit_položku}
    Type Text            id=searchGlobal      ${odstranit_položku}
    Click                text="Do košíku"
    Click                data-test=IconMinus >> nth=1

Vysypat košík
    Click                data-test=IconCart                        #css=[class="clearCart"]

*** Test Cases ***

Prihlaseni success
    Browser Settings
    Login               ucet.testing@seznam.cz              tajne@heslo&
    Get Text            data-test=notification-bell

Negativní přihlášení
    Browser Settings
    Login              ucet.testing@seznam.cz              abcdefgh
    Get Text           data-test=notification-content  ==  ${negativni_hlaska}

Krátká návštěva
    Browser Settings
    Login               ucet.testing@seznam.cz              tajne@heslo&
    Logout

# Přidání položky
#     Browser Settings
#     Login               ucet.testing@seznam.cz              tajne@heslo&
#     Get Text            data-test=notification-bell
#     Přidat do košíku    brambory
#     Přidat do košíku    tvaroh

# Odebrání položky
#     Browser Settings
#     Login               ucet.testing@seznam.cz              tajne@heslo&
#     Get Text            data-test=notification-bell
#     Odebrat z košíku    tvaroh

# Zrušení nákupu
#     Browser Settings
#     Login               ucet.testing@seznam.cz              tajne@heslo&
#     Get Text            data-test=notification-bell
#     Vysypat košík

Váhavý klient
    [Tags]  xxx
    Browser Settings
    Login               ucet.testing@seznam.cz              tajne@heslo&
    Get Text            data-test=notification-bell
    Přidat do košíku    brambory
    Zruš vyskakovací okno
    Přidat do košíku    tvaroh
    Zruš vyskakovací okno
    Odebrat z košíku    brambory
    Zruš vyskakovací okno
    Vysypat košík
