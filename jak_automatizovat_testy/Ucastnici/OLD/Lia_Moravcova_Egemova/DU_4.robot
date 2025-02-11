*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.allegro.cz/


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           kasslovalia@gmail.com           Mb4jadj2$        MS

Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly         kasslovalia@gmail.com             Mb4jadj2$
    Uživatel je přihlášen       MS


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou          kasslovalia@gmail.com              llllllll$       Účet

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          kasslovalia@gmail.com              llllllll$
    Uživatel není přihlášen



*** Keywords ***
Login_s_kontrolou
   [Arguments]      ${Email}            ${Heslo}            ${Text}

   New Browser        headless=False
   New Page           ${URL}
   Cookie           Ok, souhlasím

   sleep  10

   Click            css=[data-role="header-dropdown-toggle"]
   Click            css=[data-role="auth-button"]
   Type Text        css=[for="login"]            ${Email}
   Type Text        css=[name="password"]         ${Heslo}
   Click            css=[type="submit"]


   IF    "${Text}" == "Lia"
       Get Text     css=[data-role="header-username"]         contains            Lia
   ELSE
       Get Text     css=[data-role="header-username"]         contains            ${Text}
   END



Login_bez_kontroly
   [Arguments]          ${Email}            ${Heslo}

   New Browser        headless=False
   New Page           ${URL}
   Cookie               Ok, souhlasím

   Click            css=[data-role="header-dropdown-toggle"]
   Click            css=[data-role="auth-button"]
   Type Text        css=[for="login"]            ${Email}
   Type Text        css=[name="password"]         ${Heslo}
   Click            css=[type="submit"]

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        css=[data-role="header-username"]        contains        ${Text}


Uživatel není přihlášen

    Get Text        css=[data-role="header-username"]       contains        Přihláasit se



Cookie
    [Arguments]         ${type}
    IF  "${type}" == "Ok, souhlasím"
        Click           css=[data-testid="accept_home_view_action"]
    ELSE
        Click           css=[data-testid="reject_home_view_action"]
    END

    sleep               1



