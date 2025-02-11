*** Settings ***
Library     Browser
Resource    C:\Users\verca\Desktop\jak_automatizovat_testy\Ucastnici\Aktualni\Veronika_Krivankova\cviceniZHodin\pataHodina\Data_and_Config\TestData.robot
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor/lokátor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor data-test=login_link pokud nejsem přihlášen
...             data-test=logout_button pokud jsem přihlášen
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku


*** Variables ***
${URL}      http://testovani.kitner.cz/courses
${USER1_USER_NAME}      giyipem264@v1zw.com
${USER1_PASSWORD}       tajnenovak
${USER1_SHORT}          MS

*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
#   KS                          login                                heslo             očekávám úspěšné přihlášení
    Login_s_kontrolou           ${USER1_USER_NAME}                  ${USER1_PASSWORD}        ano

Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          ${USER1_USER_NAME}                 ${USER1_PASSWORD}



Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           ${USER1_USER_NAME}                  chyba             ne

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          ${USER1_USER_NAME}                 chyba




*** Keywords ***
Login_s_kontrolou
   [Arguments]          ${Email}            ${Heslo}            ${MaSeUzivatelPrihlsit}

   Login_bez_kontroly   ${Email}            ${Heslo}

#   Potřebuji vědět zda budu kontrolovat zda uživatel je nebo není přihlášen
#

   IF    "${MaSeUzivatelPrihlsit}" == "ano"
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


