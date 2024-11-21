*** Settings ***
Library  Browser

*** Test Cases ***
Prihlasenie na rohlik.cz pomocou invalid PSWD - negativny scenar
  Open webpage
  Invalid Login na rohlik.cz  martina.durdikova@gmail.com  xxx

Prihlasenie na rohlik.cz - pozitivny scenar
  Open webpage
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!

Odhlasenie z rohlik.cz
  Open webpage
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  Click                     id=headerUser
  BuiltIn.Sleep             3s
  Click                     data-test=user-box-logout-button

Pridanie tovaru do kosika
  Open webpage
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  Pridat tovar              Máslo
  Pridat tovar              Pivo

Vysypanie tovaru z kosika
  Open webpage
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  Vysypat kos               Máslo


*** Keywords ***
Open webpage
  #Open Browser             https://rohlik.cz  #Dava warning message " Open Browser is for quick experimentation and debugging only. Use New Page for production."
  New Browser               chromium                headless=false
  New Page                  https://rohlik.cz
  Browser.Get Title         ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
  Click                     id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll  #cookies suhlas
  sleep                     2        # nutné z důvodu chyby na rohlik.cz
  Click                     data-test=header-user-icon
  Set Strict Mode           False        # Does not fail if selector points to one or more elements

Povolenie polohy
  Click                     #neviem ako to urobit - vyskoci alert


Invalid Login na rohlik.cz
  [Arguments]          ${email}                ${wrongPSW}
# Click                id=email
# Type Text            input#email             martina.durdikova@gmail.com
  Type Text            id=email                ${email}
# click                id=password             #nemusim pouzit click, ked dam Type Text, tak to automaticky klikne
# Type Text            input#password          xxx
  Type Text            id=password             ${wrongPSW}
  click                data-test=btnSignIn
  Browser.Get Text     data-test=notification-content  ==  Zadal(a) jste nesprávný e-mail nebo heslo.

Valid Login na rohlik.cz
  [Arguments]          ${validEmail}                ${PSW}
# Click                id=email
  Type Text            id=email                     ${validEmail}
# click                id=password
  Type Text            id=password                  ${PSW}
  click                data-test=btnSignIn
  ${text} =            Browser.Get Text             xpath=//*[@id="headerUser"]/div
  log to console       ${text}
  Take Screenshot

Pridat tovar
  [Arguments]               ${tovarHladam}
# Type Text                 data-test=search-form   Máslo
  Type Text                 id=searchGlobal      ${tovarHladam}
  Sleep                     10s
# Click                     text="Do košíku"
# Click                     data-test=btnAdd     clickCount=4  #aj toto funguje, okrem clickCount
# Click                     data-test=header-search-button
# Click                     css=[data-test=btnAdd] >> nth=3
# Click                     css=[data-test=counter] >> nth=1
# Click                     data-test=IconPlus  clickCount=3  #prerobit!!!!
# Browser.Get Text          data-test=headerPrice  !=  "0,00 Kč"
  Sleep                     10s
  Hover                     data-test=cart
# Browser.Get Text          data-test=cs-price  contains  "bez dopravy"
  Browser.Get Text          data-test=cart-redirectToCart  ==  K objednávce

Vysypat kos
  [Arguments]          ${tovar}
# Type Text            data-test=search-form   Máslo
  Type Text            id=searchGlobal      ${tovar}
  Sleep                10s
  Click                text="Do košíku"
  Click                data-test=cart
  Sleep                10s
  Click                text="Vysypat košík"
  Browser.Get Text     css=.CartReview__emptySubTitle  contains  Zboží můžete



