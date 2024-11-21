*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor id=headerLogin pokud nejsem přihlášen
...             id=headerUser pokud jsem přihlášen
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           gifape5172@proexbol.com              tajneheslotajneheslo        MS

Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          gifape5172@proexbol.com              tajneheslotajneheslo
    Uživatel je přihlášen       MS


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           gifape5172@proexbol.com              chyba        Účet

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          gifape5172@proexbol.com              chyba
    Uživatel není přihlášen



*** Keywords ***
Login_s_kontrolou
   [Arguments]      ${Email}            ${Heslo}            ${Text}

   Otevri rohlik a nastav geolokaci

   Cookie           AcceptAll

   sleep  10

   Click            data-test=header-user-icon
   Type Text        id=email            ${Email}
   Type Text        id=password         ${Heslo}
   Click            data-test=btnSignIn

#   Potřebuji vědět zda budu kontrolovat zda uživatel je nebo není přihlášen
#   mohl bych přidat 4. parametr, který by obsahoval ANO nebo NE, pokud má být uživatel
#   přihlášen. Abych nemusel přidávat 4. paramter, využil jsem 3. Parametr který mi tut informaci
#   také poskytuje. Pokud uživatel nemá být přihlášen má hodnotu "Účet"
   IF    "${Text}" == "Účet"
       Get Text     data-test=header-user-icon         contains            Účet
   ELSE
       Get Text     data-test=header-user-icon         contains            ${Text}
   END



Login_bez_kontroly
   [Arguments]          ${Email}            ${Heslo}

   Otevri rohlik a nastav geolokaci

   Cookie               AcceptAll

   Click                data-test=header-user-icon
   Type Text            id=email                        ${Email}
   Type Text            id=password                     ${Heslo}
   Click                data-test=btnSignIn

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        id=headerUser       contains        ${Text}


Uživatel není přihlášen

    Get Text        data-test=header-user-icon      contains        Účet



Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

Otevri rohlik a nastav geolokaci

    New Browser        headless=false
    ${permissions} =   Create List    geolocation   # vytvoří seznam co je povoleno (v tomto případě zjištění polohy)
    New Context        permissions=${permissions}   # záznam, rozlišení, povolení zjištování polohy
    Set Geolocation    50.0859772  14.4083842  3    # zadá prohlížeči polohu: Praha - Kampa

    New Page         ${URL}
    Get Title        contains            Online supermarket Rohlik.cz