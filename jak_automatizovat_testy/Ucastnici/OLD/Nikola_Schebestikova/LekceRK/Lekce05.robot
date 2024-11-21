*** Settings ***
Library   Browser



*** Variables ***
${URL}      http://testovani.kitner.cz/courses
${USER1_USER_NAME}  giyipem264@v1zw.com
${USER_PASSSWORD}   tajnenovak
${USER_SHORT}       MS


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
#   KS                          login                                heslo             očekávám úspěšné přihlášení
    Login_s_kontrolou           ${USER1_USER_NAME}                 ${USER_PASSSWORD}      ano

Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          ${USER1_USER_NAME}                 ${USER_PASSSWORD}
    Uživatel je přihlášen       ${USER_SHORT}


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           ${USER1_USER_NAME}                  chyba             ne

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          ${USER1_USER_NAME}                  blblblala
    Uživatel není přihlášen



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

Uživatel je přihlášen
    [Arguments]     ${Text}  = to bylo na USER_SHORT - například KN = zkratka, že je uživatel přihlášen
    Get Text        data-test=logout_button       ==       ${Text}


Uživatel není přihlášen

    Get Text        data-test=login_link          ==       Přihlásit se


