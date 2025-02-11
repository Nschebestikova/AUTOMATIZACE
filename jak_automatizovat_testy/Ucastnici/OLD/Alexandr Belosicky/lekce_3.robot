*** Settings ***
Library  Browser

#*** Test Cases ***
#Starting a new browser with a page
#   New Browser    chromium    headless=false  #headless mode je teď vypnutý, tj. spustí se prohlížeč
#  New Context    viewport= ....atd   zde nastavuji, např. novou instanci pro každého uživatele, nebo rozlišení zařízení atd.
#   New Page       https://www.saucedemo.com/
#   Get Title      ==    Swag Labs  #ověřuje, že titulek té stránky se rovná textu Browser, jednodušší zápis než Should Be Equal ...vyhodnotí se rovnou v jednom kroku


#  Take Screenshot - udělá screenshot při jakémkoliv kroku; BrowserLibrary dělá screenshot automaticky, když něco selže
#  Sleep          10    #nastaví pauzu v sekundách

#   Type Text      data-test=username    Ahoj  #pokud tyto identifikátory data-test tam programátoři přidali, vybere element, napíše text Ahoj

#  Click          "Login"   #bude hledat na stránce slovo/text Login a pokud ho najde, tak na něj klikne
#  Click          id=login-button   #bude hledat podle ID, ale je potřeba smazat uvozovky, které kopíruju z kódu

#  Click          text=Login  #jiný zápis výběru elementu podle textu

*** Test Cases ***
Starting a new browser with a page
   New Browser    chromium    headless=false
   New Page       http://testovani.kitner.cz/login
   Get Title  ==  Testování - přihlášení
   Type Text      data-testid=email_input    giyipem264@v1zw.com
   Type Text      data-testid=password_input    tajnenovak
   Click          data-test=login_button  #nebo můžu napsat "Přihlásit"
   Get Text       data-test=logout_button   ==   Odhlásit se



#  Get Text      #získává text z jakéhokoliv elementu

#  Click          "Login"   #bude hledat na stránce slovo/text Login a pokud ho najde, tak na něj klikne
#  Click          id=login-button   #bude hledat podle ID, ale je potřeba smazat uvozovky, které kopíruju z kódu

#  Click          text=Login  #jiný zápis výběru elementu podle textu

#${USER1_NAME}               Michal Novák
#${USER1_EMAIL}              giyipem264@v1zw.com
#${USER1_PASSWORD}           tajnenovak

