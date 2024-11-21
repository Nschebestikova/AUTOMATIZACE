*** Settings ***
Library  Browser  timeout=10s

Test Setup  Open webpage

*** Test Cases ***
Prihlasenie na rohlik.cz pomocou invalid PSWD - negativny scenar
  Invalid Login na rohlik.cz  martina.durdikova@gmail.com  xxx

Prihlasenie na rohlik.cz - pozitivny scenar
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  [Teardown]  Logout Keyword

Odhlasenie z rohlik.cz
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  [Teardown]  Logout Keyword

Pridanie tovaru do kosika
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  Pridat tovar              Máslo
  Pridat tovar              Pivo

Vysypanie tovaru z kosika
  Open webpage
  Valid Login na rohlik.cz  rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  Vysypat kos               Máslo
  
Odstranenie jednej polozky, ked sme pridali len jednu polozku
  Open webpage
  Valid Login na rohlik.cz   rohlikrohlikovsky@seznam.cz  Rohlikovac1234!
  Odstranit jednu polozku    Máslo  

*** Keywords ***
Open webpage
  New Browser               chromium                headless=false
  New Page                  https://rohlik.cz
  Browser.Get Title         ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
  Click                     id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
  sleep                     2
  Click                     data-test=header-user-icon
  Set Strict Mode           False

Invalid Login na rohlik.cz
  [Arguments]          ${email}                ${wrongPSW}
  Type Text            id=email                ${email}
  Type Text            id=password             ${wrongPSW}
  click                data-test=btnSignIn
  Browser.Get Text     data-test=notification-content  ==  Zadal(a) jste nesprávný e-mail nebo heslo.

Valid Login na rohlik.cz
  [Arguments]          ${validEmail}                ${PSW}
  Type Text            id=email                     ${validEmail}
  Type Text            id=password                  ${PSW}
  click                data-test=btnSignIn
  ${text} =            Browser.Get Text             xpath=//*[@id="headerUser"]/div
  log to console       ${text}
  Take Screenshot

Pridat tovar
  [Arguments]               ${tovarHladam}
  Type Text                 id=searchGlobal      ${tovarHladam}
  Sleep                     10s
  Click                     text="Do košíku" >> nth=0
# Click                     data-test=btnAdd >> nth=0     #clickCount=4  #nejde mi to
  Sleep                     10s
  Hover                     data-test=cart
  Browser.Get Text          data-test=cart-redirectToCart  ==  K objednávce

Vysypat kos
  [Arguments]          ${tovar}
  Type Text            id=searchGlobal      ${tovar}
  Sleep                10s
  Click                text="Do košíku"
  Click                data-test=cart
  Sleep                10s
  Click                text="Vysypat košík"
  Browser.Get Text     css=.CartReview__emptySubTitle  contains  Zboží můžete

Odstranit jednu polozku
  [Arguments]          ${tovarOdstran}
  Type Text            id=searchGlobal      ${tovarOdstran}
  Sleep                10s
  Click                text="Do košíku"
  Click                data-test=cart
  Sleep                10s
  Click                data-test=IconMinus >> nth=1
  Browser.Get Text     data-test=headerPrice  ==  0,00\xa0Kč

Logout Keyword
  Click                     id=headerUser
  BuiltIn.Sleep             3s
  Click                     data-test=user-box-logout-button


