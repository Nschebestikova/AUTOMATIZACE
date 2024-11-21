*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor/lokátor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor id=headerLogin pokud nejsem přihlášen
...             id=headerUser pokud jsem přihlášen
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku

Resource    ../../../../../PycharmProjects/jak_automatizovat_testy/Cviceni/CV37_BrowserLib_RegistraceKurzy_cv.robot

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
#Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
#   Login_s_kontrolou           giyipem264@v1zw.com              tajnenovak          prihlasi se
#
#Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
#   Login_s_kontrolou           giyipem264@v1zw.com              chyba               neprihlasi se
#

Login - Uspesne prihlaseni - varianta bez kontroly přes IF v parametru klicoveho slova
    Login_bez_kontroly           giyipem264@v1zw.com              tajnenovak          prihlasi se
    Uzivatel je prihlasen   #v tomto případě můžu přidávat další kontroly, např. chybová hláška, což u přístupu přes IF moc nejde


Login - Chybne heslo - varianta bez kontroly přes IF v parametru klicoveho slova
    Login_bez_kontroly           giyipem264@v1zw.com              chyba               neprihlasi se
    Uzivatel neni prihlasen




*** Keywords ***
Login_s_kontrolou
  [Arguments]      ${Email}            ${Heslo}             ${Test}

  New Browser        headless=False
  New Page           ${URL}
  Get Title  ==      Testování - Přehled kurzů


  Click            data-test=login_link
  Type Text        data-test=email_input            ${Email}
  Type Text        data-test=password_input         ${Heslo}
  Click            data-test=login_button


  # kontrola přihlášení/nepřihlášení s podmínkou, aby byl test více univerzální, když se přihlásím, kontroluji text Odhlásit se, jinak kontroluji text Přihlásit se
  IF    "${Test}" == "prihlasi se"
        Get Text         data-test=logout_button       ==         Odhlásit se
  ELSE
        Get Text         data-test=login_link          ==         Přihlásit se
  END

Login_bez_kontroly
  [Arguments]      ${Email}            ${Heslo}             ${Test}

  New Browser        headless=False
  New Page           ${URL}
  Get Title  ==      Testování - Přehled kurzů


  Click            data-test=login_link
  Type Text        data-test=email_input            ${Email}
  Type Text        data-test=password_input         ${Heslo}
  Click            data-test=login_button


  # kontrola přihlášení/nepřihlášení s podmínkou, aby byl test více univerzální, když se přihlásím, kontroluji text Odhlásit se, jinak kontroluji text Přihlásit se
  IF    "${Test}" == "prihlasi se"
        Get Text         data-test=logout_button       ==         Odhlásit se
  ELSE
        Get Text         data-test=login_link          ==         Přihlásit se
  END

Uzivatel je prihlasen
   Get Text         data-test=logout_button       ==         Odhlásit se

Uzivatel neni prihlasen
   Get Text         data-test=login_link          ==         Přihlásit se
