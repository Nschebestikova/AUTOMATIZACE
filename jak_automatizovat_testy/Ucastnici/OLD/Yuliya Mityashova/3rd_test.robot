*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor/lokátor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor id=headerLogin pokud nejsem přihlášen
...             id=headerUser pokud jsem přihlášen
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku

pip pip install robotframework-request


*** Variables ***
${URL}      http://testovani.kitner.cz/courses




*** Test Cases ***


Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
   Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
   Login_s_kontrolou           giyipem264@v1zw.com                  chyba








*** Keywords ***
Login_s_kontrolou
  [Arguments]      ${Email}            ${Heslo}
#   [Arguments]      ${Email}            ${Heslo}            ${Text}


  New Browser        headless=False
  New Page           ${URL}
  Get Title  ==      Testování - Přehled kurzů


  Click            data-test=login_link
  Type Text        data-test=email_input            ${Email}
  Type Text        data-test=password_input         ${Heslo}
  Click            data-test=login_button


  # kontrola
  Get Text         data-test=logout_button       ==            Odhlásit se
  Get url       ==      http://testovani.kitner.cz/courses
