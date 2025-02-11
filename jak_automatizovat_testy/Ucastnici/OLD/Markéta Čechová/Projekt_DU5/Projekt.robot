*** Settings ***
Library     Browser

Resource    TestData.robot
Resource    Configuration.robot

Suite Setup         Pred_sadou
Suite Teardown      Uklid_po_sade

Test Setup          Pred_testem
Test Teardown       Po_testu


*** Test Cases ***
# Pozitivní testy
Prihlaseni - správné údaje
    Prihlaseni      ${USER1_EMAIL}    ${USER1_PASSWORD}
    Kontrola prihlasen

Odhlasit_uzivatele
    Prihlaseni      ${USER1_EMAIL}    ${USER1_PASSWORD}
    Odhlaseni
    Kontrola neprihlasen


# Negativní testy
Prihlaseni - mail OK, heslo KO
    Prihlaseni      ${USER1_EMAIL}              AAAAAAAAAAAAA
    Sleep           1
    Kontrola neprihlasen
    Chybova hlaska - spatne zadany mail nebo heslo

Prihlaseni - mail KO, heslo OK
    Prihlaseni     novak@v1zw.com           ${USER1_PASSWORD}
    Kontrola neprihlasen
    Chybova hlaska - spatne zadany mail nebo heslo

Prihlaseni - mail KO, heslo KO
    Prihlaseni     novak@v1zw.com           AAAAAAAAAAAAA
    Kontrola neprihlasen
    Chybova hlaska - spatne zadany mail nebo heslo

Prihlaseni - mail prazdy, heslo OK
    Prihlaseni       ${EMPTY}               ${USER1_PASSWORD}
    Kontrola neprihlasen
    Chybova hlaska - prazdny mail

Prihlaseni - mail OK, heslo prazdne
    Prihlaseni       ${USER1_EMAIL}        ${EMPTY}
    Kontrola neprihlasen
    Chybova hlaska - prazdne heslo

#Registrace na kurz
Registrace na kurz
    Prihlaseni      ${USER1_EMAIL}    ${USER1_PASSWORD}
    Registrace na kurz cislo 3      ${ICO}    ${TELEFON}


*** Keywords ***

Prihlaseni
    [Arguments]     ${USER_EMAIL}                          ${USER_PASSWORD}

    Type Text       ${SEL_LoginFormEmail}                   ${USER_EMAIL}
    Type Text       ${SEL_LoginFormPwd}                     ${USER_PASSWORD}
    Click           ${SEL_UserLoginBtn}

Odhlaseni
    Click           ${SEL_UserLogoutBtn}

# Kontroly
Kontrola prihlasen
    Get Text        ${SEL_UserLogoutBtn}            ==      ${TEXT_Ohlasit}
    Log             Uživatel je přihlášen

Kontrola neprihlasen
    Get Text        ${SEL_LoginLink}                ==      ${TEXT_Prihlasit}
    Log             Uživatel je odhlašen

# Chybové hlášky
Chybova hlaska - spatne zadany mail nebo heslo
    Get Text        ${SEL_LoginErrorTxt}      ==      ${ERROR_TEXT_IncorrectEmailOrPwd}
    Log             Špatně zadané údaje

Chybova hlaska - prazdny mail
    Get Text        ${SEL_LoginErrorTxt}      ==      ${ERROR_TEXT_EmptyEmail}
    Log             Nezadán email

Chybova hlaska - prazdne heslo
    Get Text        ${SEL_LoginIncorrectPwd}       ==      ${ERROR_TEXT_EmptyPwd}
    Log             Nezadáno heslo

# Registrace
Registrace na kurz cislo 3
    [Arguments]         ${ICO}                          ${TELEFON}
    Set Strict Mode     off
    Click               ${REG_CourseInfoBtn}
    Click               ${REG_RegistrationBtn}
    Type Text           ${REG_IcoInput}                 ${ICO}
    Type Text           ${REG_TelInput}                 ${TELEFON}
    Click               ${REG_RegistrationBtn}
    Wait For Alert      Accept
    Get Text            ${REG_Confirmation}       ==      ${TEXT_Registrace}
#registrace nefunguje při naplnění kapacity kurzu


Pred_sadou
    ${b_timeput} =      Set Browser Timeout             ${TIMEOUT_BROWSER}
    New Browser         browser=${prohlizec}            headless=False
    New Page            ${URL_login}

Uklid_po_sade
    Close Browser


Pred_testem
  #${b_timeput} =      Set Browser Timeout             ${TIMEOUT_BROWSER}
  #  New Browser         browser=${prohlizec}            headless=False
  #  New Page            ${URL_login}
    Go To           ${URL_login}
    Sleep           1

Po_testu
    Go to       ${URL_courses}
    Sleep    1000ms
    ${menu} =   Get Text        ${SEL_Menu}
    Log to Console       ${menu}
    IF      "Odhlásit se" in '''${menu}'''
            Log  Úklid - Uživatel není odhlášen
            Odhlaseni
    ELSE
            Log  Úklid - Uživatel je odhlášen
    END