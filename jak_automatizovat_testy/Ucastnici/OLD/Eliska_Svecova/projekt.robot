*** Settings ***
Library  Browser

*** Variables ***

    # Selektor na Cookies
${SEL_cookies}              id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    #   Selektory na účet
${SEL_ucet}                 css=.sc-33d19302-0 gLxZbZ  #<button data-test="button" type="button" class="sc-33d19302-0 gLxZbZ"><div class="sc-33d19302-1 eRjJAU"><svg data-test="IconUserLogin" height="22" viewBox="0 0 18 22" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M17.2 21a.81.81 0 0 1-.79-.83c0-5.41-4.43-6.04-4.62-6.06a.8.8 0 0 1-.62-.48.89.89 0 0 1 .06-.8c.02-.04 1.76-2.87 1.76-6.39 0-3.16-1.28-3.77-3.5-3.77-2.22 0-3.5.61-3.5 3.77a13.3 13.3 0 0 0 1.76 6.38c.15.24.17.55.06.8a.8.8 0 0 1-.62.49c-.18.02-4.15.62-4.58 5.22h10.57c.44 0 .8.38.8.84 0 .46-.36.83-.8.83H1.78a.81.81 0 0 1-.79-.83c0-5.02 3.17-6.82 4.9-7.43a14.96 14.96 0 0 1-1.49-6.3C4.4 1.56 7.31 1 9.49 1c2.18 0 5.09.56 5.09 5.44 0 2.73-.89 5.05-1.49 6.3 1.73.61 4.9 2.41 4.9 7.43 0 .46-.35.83-.79.83z" fill="#1C2529"></path></svg></div>Účet</button>
${SEL_okno}                 css=.sc-27d123d7-0 cVaKwJ
${SEL_prihlaseni}           data-test=btnSignIn        #<button data-test="btnSignIn" type="submit" class="sc-33d19302-0 jpkyuK">Přihlásit se</button>
${SEL_overeni_prihlaseni}   data-test=header-user-icon
${SEL_odhlaseni}            css=.sc-c54407f5-11 dTkofz h-flexCenter

*** Test Cases ***

Zobrazeni hlavni stranky Rohlik
    New Browser             chromium    headless=false
    New Page                https://www.rohlik.cz/
    Get Title               contains    Vítejte na Rohlíku

    #odkliknout cookies
    Hover          ${SEL_cookies}
    Sleep          1

    #kliknout na ikonu účet
    Hover          ${SEL_ucet}
    Sleep          1
    Get Text       ${SEL_okno}    ==  Přihlášení

    #zobrazeni prihlaseni
Prihlasit se
    Login          bezi.liska1@seznam.cz    K_Taboru+   BL
    Hover          ${SEL_prihlaseni}
    Click          ${SEL_prihlaseni}
    Take Screenshot
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${nastane}
    Get text       ${SEL_overeni_prihlaseni}    ==  BL

Odhlaseni se
    Hover          ${SEL_overeni_prihlaseni}
    Click          ${SEL_overeni_prihlaseni}
    Click          ${SEL_odhlaseni}
    #ověřit, že účet neobsahuje to co je v ${nastane}
    Get text       ${SEL_ucet}     !=   BL


*** Keywords ***
Login
    [Arguments]     ${email}      ${heslo}     ${nastane}

    log             ${email}
    log             ${heslo}
    log             ${nastane}