*** Settings ***
Library     Browser
Resource    Data_and_Config/KonfiguraceN.robot
Resource    Data_and_Config/TestovaciData.robot
Resource    Data_and_Config/Chyb_hlasky.robot


Suite Setup     Before_SET
Test Setup      Before_TEST

Test Teardown   END_Uklid_TESTS
Suite Teardown  Uklid_AFTER_TEST

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}   #TIMEOUT PRO VŠECHNY TESTY

#*** Variables ***
#${URL}  http://testovani.kitner.cz/courses

#testy pozitivní a negativní na kontrolu přihlášení
*** Test Cases ***

#positive test
Login - správné prihlášení kontrola
    Login_checkout              ${Email}              ${Password}       yes
#   [Teardown]    Logout             #= DOTAZ - mi tady nefunguje, netuším proč?

#negative test - ŠPATNÉ PŘIHLÁŠENÍ
Login - spatne prihlaseni
    Login_checkout              ${EMPTY}              ${badPassword}    no


# test bez kontroly - SPRÁVNÉ PŘIHLÁŠENÍ
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

#CHYBOVÉ HLÁŠKY
Uživatel je přihlášen
    Get Text        ${SEL_UserLogoutBatton}            ==       ${TEXT_Odhlasit}
    Take Screenshot
Uživatel není přihlášen
    Get Text        ${SEL_LoginLink}                ==       ${TEXT_Prihlasit}
    Take Screenshot
Chybova hlaska neplatne udaje
    Get Text   ${SEL_LoginErrorTxt}       *=  ${SEL_LoginIncorrectEmail}
    Take Screenshot
Chybova hlaska prazdny email
     Get Text   ${SEL_LoginErrorTxt}       *=  ${ERROR_TEXT_PrázdnyEmail}
     Take Screenshot
Chybova hlaska prazdne heslo
     Get Text   ${SEL_LoginIncorrectPwd}   *=  ${ERROR_TEXT_PrazdnyPassword}
     Take Screenshot

#UKLIDY PO TESTECH a AKCE PŘED TESTY
Before_SET
   ${b_timeout} =     Set Browser Timeout                 ${TIMEOUT_BROWSER}
   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      Testování - Přehled kurzů

Before_TEST
   Go To              ${URL}

Uklid_AFTER_TEST
   Close Browser

END_Uklid_TESTS
    Log         Uklid na konci testů
    Close Browser


