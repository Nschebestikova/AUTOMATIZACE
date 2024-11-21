*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor/lokátor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor data-test=login_link pokud nejsem přihlášen
...             data-test=logout_button pokud jsem přihlášen
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku


*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
#   KS                          login                                heslo             očekávám úspěšné přihlášení
    Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak        ano

Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          giyipem264@v1zw.com                  tajnenovak
    Uživatel je přihlášen       MS


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           giyipem264@v1zw.com                  chyba             ne

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          giyipem264@v1zw.com                  chyba
    Uživatel není přihlášen



*** Keywords ***
Login_s_kontrolou
   [Arguments]          ${Email}            ${Heslo}            ${MaSePrihlsit}

   Login_bez_kontroly   ${Email}            ${Heslo}

#   Potřebuji vědět zda budu kontrolovat zda uživatel je nebo není přihlášen
#

   IF    "${MaSePrihlsit}" == "ano"
       Get Text     data-test=logout_button       ==            Odhlásit se
   ELSE  # nemá být přihlášen
       Get Text     data-test=login_link          ==            Přihlásit se
   END



Login_bez_kontroly
   [Arguments]          ${Email}            ${Heslo}

   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      Testování - Přehled kurzů

   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}
   Type Text        data-test=password_input         ${Heslo}
   Click            data-test=login_button

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        data-test=logout_button       ==       Odhlásit se


Uživatel není přihlášen

    Get Text        data-test=login_link          ==       Přihlásit se


