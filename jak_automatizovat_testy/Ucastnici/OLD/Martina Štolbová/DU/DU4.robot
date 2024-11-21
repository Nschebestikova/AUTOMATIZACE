*** Settings ***
Library         Browser
*** Variables ***
${URL1}      https://www.zajezdy.cz/
${URL2}      https://www.zajezdy.cz/moje-zajezdy/
${e-mail}    martina.stolbova@seznam.cz
${heslo}     Heslo123
${cookies}   id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${badheslo}  123

*** Test Cases ***

Prihlaseni
     Prihlaseni           ${e-mail}      ${heslo}            "Můj účet"

Přihlášení - negativ
    Prihlaseni - negativ     ${e-mail}      ${badheslo}     $potvrzeni1
Moje zájezdy
     Oblíbený zájezd    ${e-mail}    ${heslo}    $potvrzeni1
Vyhledání zájezdu a přidání do oblíbených
      Přidání zájezdu do oblíbených    ${e-mail}     ${heslo}     $potvrzeni1
Odhlášení
      Odhlášení   ${e-mail}  ${heslo}    $potvrzeni1

*** Keywords **

Prihlaseni
     [Arguments]          ${e-mail}          ${heslo}          ${potvrzeni1}

     New Browser          chromium  headless=false
     New Page             ${URL1}
     Get Title            ==  Zájezdy.cz | Dovolená v pohodě a hned | Zájezdy.cz

     Click                css=#CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
     Click                css=.header-collapse >> nth=1
     Type Text            css=#username        ${e-mail}
     Type Text            css=#password        ${heslo}
     Click                selector=//button[@type="submit"]
Potvrzení
     Wait For Elements State    selector=//*[@class="super-extra-small"]
Prihlaseni - negativ
     [Arguments]          ${e-mail}          ${badheslo}          ${potvrzeni1}

     New Browser          chromium  headless=false
     New Page             ${URL1}
     Get Title            ==  Zájezdy.cz | Dovolená v pohodě a hned | Zájezdy.cz

     Click                css=#CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
     Click                css=.header-collapse >> nth=1
     Type Text            css=#username        ${e-mail}
     Type Text            css=#password        ${badheslo}
     Click                selector=//button[@type="submit"]
Odhlášení
    [Arguments]          ${e-mail}          ${heslo}          ${potvrzeni1}

     New Browser          chromium  headless=false
     New Page             ${URL1}
     Get Title            ==  Zájezdy.cz | Dovolená v pohodě a hned | Zájezdy.cz

     Click                css=#CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
     Click                css=.header-collapse >> nth=1
     Type Text            css=#username        ${e-mail}
     Type Text            css=#password        ${heslo}
     Click                selector=//button[@type="submit"]
     Click                selector=//*[@class="super-extra-small"]
     Sleep      5
     Click                  css=#logout
Ověřeno
     Wait For Elements State     css=.header-collapse >> nth=1
     Take Screenshot
Cookies
     [Arguments]          ${type}
     IF  "${type}" == "AcceptAll"
          Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
     ELSE
          Click           id="CybotCookiebotDialogBodyButtonDecline"
     END
Oblíbený zájezd
    [Arguments]          ${e-mail}          ${heslo}          ${potvrzeni1}

     New Browser          chromium  headless=false
     New Page             ${URL1}
     Get Title            ==  Zájezdy.cz | Dovolená v pohodě a hned | Zájezdy.cz
     Click                css=#CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
     Click                css=.header-collapse >> nth=1
     Type Text            css=#username        ${e-mail}
     Type Text            css=#password        ${heslo}
     Click                selector=//button[@type="submit"]
     Sleep    2
     Click                css=.header-collapse >> nth=0
     Take Screenshot
     Sleep    10

Přidání zájezdu do oblíbených
    [Arguments]          ${e-mail}          ${heslo}          ${potvrzeni1}

     New Browser          chromium  headless=false
     New Page             ${URL1}
     Get Title            ==  Zájezdy.cz | Dovolená v pohodě a hned | Zájezdy.cz
     Click                css=#CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
     Click                css=.header-collapse >> nth=1
     Type Text            css=#username        ${e-mail}
     Type Text            css=#password        ${heslo}
     Click                selector=//button[@type="submit"]
     Sleep    2
     Click                 css=#search-box-locationInput
     Type Text             css=#search-box-locationInput       Abu Dhabí
     Click                 css=#sb-listing
     Sleep   10
     Click    selector=//button[@type="Do mých zájezdů"][@a ng-href="https://www.zajezdy.cz/dovolena-rixos-premium-saadiyat-island-abu-dhabi-spojene-arabske-emiraty-z2540184/?index=0&zeme=z221&dest=d22101"]
