*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor/lokátor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor id=headerLogin pokud nejsem přihlášen
...             id=headerUser pokud jsem přihlášen
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku


*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak        prihlasi se


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           giyipem264@v1zw.com                  chyba             neprihlasi se



Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          giyipem264@v1zw.com                  tajnenovak
    Uživatel je přihlášen

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          giyipem264@v1zw.com                  chyba
    Uživatel není přihlášen



*** Keywords ***
Login_s_kontrolou
   [Arguments]      ${Email}            ${Heslo}            ${Text}

   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      Testování - Přehled kurzů

   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}
   Type Text        data-test=password_input         ${Heslo}
   Click            data-test=login_button

#kontrola
#   Get Url          ==                                      http://testovani.kitner.cz/courses
#   Get Text     data-test=logout_button       ==            Odhlásit se
#   Potřebuji vědět zda budu kontrolovat zda uživatel je nebo není přihlášen
#   mohl bych přidat 4. parametr, který by obsahoval ANO nebo NE, pokud má být uživatel
#   přihlášen. Abych nemusel přidávat 4. parametr, využil jsem 3. Parametr který mi tuto informaci
#   také poskytuje. Pokud uživatel nemá být přihlášen má hodnotu "Účet"
   IF    "${Text}" == "prihlasi se"
       Get Text     data-test=logout_button       ==            Odhlásit se
   ELSE
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
 #   [Arguments]     ${Text}
    Get Text        data-test=logout_button       ==       Odhlásit se


Uživatel není přihlášen

    Get Text        data-test=login_link          ==       Přihlásit se


