*** Settings ***

Library  Browser

*** Variables ***
${url}                      https://www.rohlik.cz/

    # Selektor na Cookies
${SEL_cookies+}             id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    # Selektro na otevření přihlašovací stránky
${SEL_bth_ucet}             data-test=header-user-icon  # css=[class="sc-c54407f5-12 lnnHxr"]
    #   Selektory na účet
${SEL_prihlasovaci_box}     data-test=login-box-wrapper
${SEL_email}                id=email
${SEL_heslo}                id=password
${SEL_btn_prihlasit_se}     css=[data-test="btnSignIn"]
${SEL_hlavicka_prihlaseni}  id=headerUser
${SEL_overeni_prihlaseni}   data-test=header-user-icon
${SEL_odhlaseni}            data-test=user-box-logout-button
    #Selektory k nákupu
${SEL_vyhledavac}           id=searchGlobal
${SEL_do_kosiku}            data-test=counter
${SEL_kosik_soucet}         data-test=headerPrice
${SEL_kosik_mnozstvi}       class=.sc-c57c261e-4 jWscLy cartCount
${SEL_kosik}                data-test=IconCart



*** Test Cases ***



Prihlasit se -
    
    Zobrazeni hlavni stranky

    Login-             bezi.liska1@seznam.cz    xxx         Zadal(a) jste nesprávný e-mail

Prihlasit se +
    Zobrazeni hlavni stranky

    Login+             bezi.liska1@seznam.cz    K_Taboru+   BL

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${nastane}



Odhlaseni se
    Zobrazeni hlavni stranky
    Login+             bezi.liska1@seznam.cz    K_Taboru+   BL

    Click               ${SEL_hlavicka_prihlaseni}
    Click               ${SEL_odhlaseni}
    #ověřit, že účet neobsahuje to co je v ${nastane}
    Get text            ${SEL_bth_ucet}  ==   Účet

Pridani zbozi do kosiku
    Zobrazeni hlavni stranky
    Login+             bezi.liska1@seznam.cz    K_Taboru+   BL

    Kosik               čokoláda
    #Kosik               mléko


Odebrani zbozi do kosiku
    Zobrazeni hlavni stranky
    Login+             bezi.liska1@seznam.cz    K_Taboru+   BL
    Vysypat kosik      čokoláda

*** Keywords ***
Zobrazeni hlavni stranky

    #Zobrazeni stranky Rohlik
    New Browser             chromium    headless=false

    #Geolokace
    ${permissions} =        Create List    geolocation   # vytvoří seznam co je povoleno (v tomto případě zjištění polohy)
    New Context             permissions=${permissions}   # záznam, rozlišení, povolení zjištování polohy
    Set Geolocation         50.0859772     14.4083842  3    # zadá prohlížeči polohu: Praha - Kampa

    New Page                ${url}
    Get Title               contains       Online supermarket Rohlik.cz
    Set Strict Mode         False

    #Cookies
    Click               ${SEL_cookies+}                    #Povolit všechny
    Sleep               3s
    Click               ${SEL_bth_ucet}


Login-
    [Arguments]         ${email}        ${heslo}      ${vysledek}
    Type Text           id=email        ${email}      #selektor k prihlaseni emailu a nazev email
    Type Text           ${SEL_heslo}    ${heslo}      #selektor k nalezeni hesla a heslo
    Click               ${SEL_btn_prihlasit_se}
    Get Text            ${SEL_prihlasovaci_box}       contains    ${vysledek}



Login+
    [Arguments]         ${email}        ${heslo}       ${nastane}

    Type Text           ${SEL_email}    ${email}
    Type Text           ${SEL_heslo}    ${heslo}
    Click               ${SEL_btn_prihlasit_se}
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${nastane}
    Get text            ${SEL_hlavicka_prihlaseni}    contains  ${nastane}


Kosik
    [Arguments]         ${nakup}

    Type Text           ${SEL_vyhledavac}   ${nakup}         #id=searchGlobal  čokoláda
    #Click               data-test=header-search-button
    #Click               text="Do košíku" >> nth=0         #1 ks
    Click               data-test=btnAdd
    Sleep               10
    Take Screenshot
    #Click               data-test=modal-close-button            #zavřu okno s adresou, kam doručit nákup
    #Sleep               5s
    Hover               data-test=cart                     #data-test=headerPrice
    #Hover               data-test=IconCart
    Take Screenshot
    Sleep               10s

    Browser.Get text    data-test=cart-redirectToCart    ==  K objednávce
    Click               data-test=IconMinus               #vyprázdním košík
    Sleep               2s
    Take Screenshot

Vysypat kosik
  [Arguments]           ${nakup-}
  Type Text             ${SEL_vyhledavac}      ${nakup-}
  Click                 text="Do košíku"         #data-test=btnAdd
  #Click                data-test=IconMinus >> nth=1
  #Click                data-test=cart
  Sleep                 10s
  Hover                 data-test=cart
  Click                 data-test=IconMinus
  Browser.Get Text      id=cartContent    contains  Vytvořit nákupní seznam