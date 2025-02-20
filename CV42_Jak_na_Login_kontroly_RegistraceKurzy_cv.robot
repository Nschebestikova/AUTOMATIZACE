*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor/lokátor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor data-test=login_link pokud nejsem přihlášen
...             data-test=logout_button pokud jsem přihláše
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku


*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
#   KS                          login                                heslo             očekávám úspěšné přihlášení
    Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak        ano


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           giyipem264@v1zw.com                  chyba             ne



*** Keywords ***
Login_s_kontrolou
   [Arguments]          ${Email}            ${Heslo}            ${Text}

   # Doplní kód pro login

   # Doplní kód pro kontrolu



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


