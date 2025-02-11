*** Settings ***
Library  Browser


*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
#Registrace
Registrace - úspěch
    Registrace uživatele    ŽelvíNinja      xameja1700+1245@ubinert.com        silneheslo      Ano

Registrace - neúspěch (již registrovaný e-mail)
    Registrace uživatele    ŽelvíNinja2     xameja1700+124@ubinert.com        silneheslo      Ne

#Přihlášení
Přihlášení - úspěch
    Login s kontrolou       xameja1700+124@ubinert.com        silneheslo      Ano

Přihlášení - neúspěch (chybný e-mail)
    Login s kontrolou       xameja1700+124@u.com              silneheslo      Ne

Přihlášení - neúspěch (chybné heslo)
    Login s kontrolou       xameja1700+124@ubinert.com        spatneheslo     Ne

#Odhlášení
Odhlášení - úspěch
    Login s kontrolou       xameja1700+124@ubinert.com        silneheslo      Ano
    Logout s kontrolou      Ano


*** Keywords ***
Registrace uživatele
    [Arguments]     ${jmeno}        ${email}        ${heslo}        ${text}

    Log             ${jmeno}
    Log             ${email}
    Log             ${heslo}
    Log             ${text}

    New Browser     chromium        headless=False
    New Page        ${URL}
    Get Title       ==              Testování - Přehled kurzů

    Click           data-testid=login_link
    Click           data-testid=register_link
    Get Text        data-testid=register_text
    Type Text       data-testid=name_input                 ${jmeno}
    Type Text       data-testid=email_input                ${email}
    Type Text       data-testid=password_input             ${heslo}
    Type Text       data-testid=password_again_input       ${heslo}
    Click           data-testid=register_button

    IF   "${text}"=="Ano"
        Get Text          data-testid=logout_button   ==  Odhlásit se
        Log To Console    Uživatel byl registrován.
    ELSE
        Get Text          data-testid=register_button    ==   Registrovat
        Log To Console    Uživatel nebyl registrován.
    END

Login s kontrolou
   [Arguments]      ${email}    ${heslo}    ${text}

    Log             ${email}
    Log             ${heslo}
    Log             ${text}

    New Browser     chromium        headless=False
    New Page        ${URL}
    Get Title       ==              Testování - Přehled kurzů

    Click           data-testid=login_link
    Type Text       data-testid=email_input         ${email}
    Type Text       data-testid=password_input      ${heslo}
    Click           data-testid=login_button

    IF   "${text}"=="Ano"
        Get Text            data-testid=logout_button     ==      Odhlásit se
        Log To Console      Uživatel byl přihlášen.
    ELSE
        Get Text            data-testid=login_link        ==      Přihlásit se
        Log To Console      Uživatel nebyl přihlášen.
    END

Logout s kontrolou
    [Arguments]         ${text}

    Log                 ${text}

    Click               data-testid=logout_button

    IF   "${text}"=="Ano"
        Get Text            data-testid=login_link        ==      Přihlásit se
        Log To Console      Uživatel byl odhlášen.
    ELSE
        Get Text            data-testid=logout_button     ==      Odhlásit se
        Log To Console      Uživatel nebyl odhlášen.
    END