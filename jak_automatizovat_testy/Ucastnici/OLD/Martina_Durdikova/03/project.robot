*** Settings ***
Library  Browser
Library    SeleniumLibrary

*** Test Cases ***
Prihlasenie na rohlik.cz pomocou invalid PSWD
  Otvorenie stranky
  Cookies suhlas
  Click  data-test=header-user-icon
  Invalid Login na rohlik.cz

Prihlasenie na rohlik.cz - pozitivny scenar
  Otvorenie stranky
  Cookies suhlas
  Click  data-test=header-user-icon
  Valid Login na rohlik.cz
  ${text} =     Browser.Get Text   xpath=//*[@id="headerUser"]/div
  log to console       ${text}
  Take Screenshot

Odhlasenie z rohlik.cz
  Otvorenie stranky
  Cookies suhlas
  Click  data-test=header-user-icon
  Valid Login na rohlik.cz
  ${text} =     Browser.Get Text   xpath=//*[@id="headerUser"]/div
  log to console       ${text}
  Take Screenshot
  Click  id=headerUser
  BuiltIn.Sleep  3s
  Click  data-test=user-box-logout-button





*** Keywords ***
Otvorenie stranky
  #Open Browser  https://rohlik.cz  #Dava warning message " Open Browser is for quick experimentation and debugging only. Use New Page for production."
  New Browser  chromium  headless=false
  New Page  https://rohlik.cz
  Browser.Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě


Cookies suhlas
     # odklikne cookies
   Click       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
   sleep       2        # nutné z důvodu chyby na rohlik.cz

Povolenie polohy
  Click  #neviem ako to urobit - vyskoci alert


Invalid Login na rohlik.cz
  Click  id=email
  Type Text  input#email  martina.durdikova@gmail.com
  click  id=password  #nemusim pouzit click, ked dam Type Text, tak to automaticky klikne
  Type Text  input#password  xxx
  click  data-test=btnSignIn
  Browser.Get Text    data-test=notification-content  ==  Zadal(a) jste nesprávný e-mail nebo heslo.

Valid Login na rohlik.cz
  Click  id=email
  Type Text  input#email  rohlikrohlikovsky@seznam.cz
  click  id=password
  Type Text  input#password  Rohlikovac1234!
  click  data-test=btnSignIn



