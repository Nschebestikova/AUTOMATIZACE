*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses
${nic}      ""
*** Test Cases ***
Login - Pozitivni - Uspesne prihlaseni
#   TC                          Login                                Heslo             Prihlasen
    Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak        Ano

Login - Negativni - Spatne jmeno
    Login_s_kontrolou           totojmenojeblbost                    tajnenovak        Ne

Login - Negativni - Spatne heslo
    Login_s_kontrolou           giyipem264@v1zw.com                  spatneheslo       Ne

Registrace - uspesna
#   TC                          jmeno                  email                               heslo              Zaregistroval se
    Uzivatel se zaregistruje    Totopujde              spravnyemail@seznam.cz             tajnenovak          Ano

Registrace - neuspesna - nevyplněné heslo
    Uzivatel se zaregistruje    Totonepujde            negativnitest@seznam.cz            ${nic}          Ne

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

    IF   "${Text}"=="Ano"
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

    IF   "${Text2}"=="Ano"
        Get Text          data-test=logout_button   ==  Odhlásit se
        Log To Console    Je registrovan
    ELSE
        Get Text          data-test=register_button    ==   Registrovat
        Log To Console    Neni registrovan
    END
