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

Login - Uspesne prihlaseni
#   KS                          login                                heslo             Mám se přihlásit
    Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak        Ano

Login - Neuspesne prihlaseni - chybne neexistujici jmeno
    Login_s_kontrolou           netocnaklara@sdifjasf.com            tajnenovak        Ne

Login - Neuspesne prihlaseni - Chybne heslo
    Login_s_kontrolou           giyipem264@v1zw.com                  chyba             Ne

Registrace - uspesna
#   KS                          jmeno                  email                               heslo              Zaregistroval se
    Uzivatel se zaregistruje    KlaraNet               netocnaklar@wizz123.com             tajnenovak          Ano

Registrace - neuspesna - nespravny email
    Uzivatel se zaregistruje    KlaraNe                netocnaklara                         tajnenovak          Ne

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

    IF   "${Text}"=="Ano"   #texty musi byt v uvozovkach
        Get Text          data-test=logout_button   ==  Odhlásit se
        Log To Console    Je prihlasen
    ELSE
        Get Text          data-test=login_link    ==   Přihlásit se
        Log To Console    Neni prihlasen
    END

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        data-test=logout_button       ==       Odhlásit se


Uživatel není přihlášen

    Get Text        data-test=login_link          ==       Přihlásit se


Uzivatel se zaregistruje
    [Arguments]      ${Jmeno}           ${Email}            ${Heslo}            ${Text2}

    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      Testování - Přehled kurzů

    Click            data-test=login_link
    Click            data-test=register_link
    Get Text         data-test=register_text
    Type Text        data-test=name_input              ${Jmeno}
    Type Text        data-test=email_input              ${Email}
    Type Text        data-test=password_input           ${Heslo}
    Type Text        data-test=password_again_input     ${Heslo}
    Click            data-test=register_button

    IF   "${Text2}"=="Ano"   #texty musi byt v uvozovkach
        Get Text          data-test=logout_button   ==  Odhlásit se
        Log To Console    Je registrovan
    ELSE
        Get Text          data-test=register_button    ==   Registrovat
        Log To Console    Neni registrovan
    END
