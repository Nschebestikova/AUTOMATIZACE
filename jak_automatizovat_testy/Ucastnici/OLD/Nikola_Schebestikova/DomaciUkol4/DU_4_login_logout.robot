*** Settings ***
Library   Browser

*** Variables ***
${URL}       http://testovani.kitner.cz/courses
${Email}     nikolaschebestikova@gmail.com
${Password}   Testerka123
${badPassword}  Testerka321
${JePrihlasen}  yes

#testy pozitivní a negativní na kontrolu přihlášení
*** Test Cases ***

#positive test
Login - správné prihlášení kontrola
    Login_checkout              ${Email}              ${Password}       yes

#negative test
Login - spatne prihlaseni
    Login_checkout              ${Email}              ${badPassword}    no


# test bez kontroly
Login - bez kontroly
   Login_uncheck              ${Email}               ${Password}

# test na odhlášení s kontrolou
Logout - odhlášení s kontrolou
    Logout_checkout   ${Email}            ${Password}            ${JePrihlasen}


#Klíčová slova pro kontroly loginu a open page přihlašeni a odhlášení
*** Keywords ***
#login s kontrolou
Login_checkout
   [Arguments]          ${Email}            ${Password}            ${JePrihlasen}

   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      Testování - Přehled kurzů
   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}
   Type Text        data-test=password_input         ${Password}
   Click            data-test=login_button
# Kód pro kontrolu přihlášení - podmínky
   IF    "${JePrihlasen}" == "yes"
      Log To Console    Uživatel je přihlášen - správně
      Get Text          data-test=logout_button    ==   Odhlásit se
   ELSE
      Log To Console    Uživatel není přihlášen - špatně
      Get Text          data-test=login_link          ==    Přihlásit se
   END


#logout s kontrolou
Logout_checkout
    [Arguments]        ${Email}            ${Password}            ${JePrihlasen}

    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      Testování - Přehled kurzů
    Click            data-test=login_link
    Type Text        data-test=email_input            ${Email}
    Type Text        data-test=password_input         ${Password}
    Click            data-test=login_button

    IF    "${JePrihlasen}" == "yes"
        Click            data-test=logout_button
        Log To Console    Uživatel byl úspěšně odhlášen
    ELSE
        Log To Console    Uživatel nebyl odhlášen
    END

#login bez kontroly
Login_uncheck
    [Arguments]       ${Email}            ${Password}

    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      Testování - Přehled kurzů
    Click            data-test=login_link
    Type Text        data-test=email_input            ${Email}
    Type Text        data-test=password_input         ${Password}
    Click            data-test=login_button




