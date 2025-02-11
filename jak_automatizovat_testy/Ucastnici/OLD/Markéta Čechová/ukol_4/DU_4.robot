*** Settings ***
Library     Browser


*** Variables ***
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak
${PRAZDNY}                  ${EMPTY}

*** Test Cases ***
# Pozitivní testy
Prihlaseni - správné údaje

    Prihlaseni      giyipem264@v1zw.com    tajnenovak
    Kontrola prihlasen

Odhlaseni
    Prihlaseni      giyipem264@v1zw.com    tajnenovak
    Odhlaseni
    Kontrola neprihlasen


# Negativní testy
Prihlaseni - mail OK, heslo KO
    Prihlaseni      giyipem264@v1zw.com    AAAAAAAAAAAAA
    Kontrola neprihlasen
    Chybova hlaska - spatne zadany mail nebo heslo

Prihlaseni - mail KO, heslo OK
    Prihlaseni     novak@v1zw.com           tajnenovak
    Kontrola neprihlasen
    Chybova hlaska - spatne zadany mail nebo heslo

Prihlaseni - mail KO, heslo KO
    Prihlaseni     novak@v1zw.com           AAAAAAAAAAAAA
    Kontrola neprihlasen
    Chybova hlaska - spatne zadany mail nebo heslo

Prihlaseni - mail prazdy, heslo OK
    Prihlaseni       ${PRAZDNY}               tajnenovak
    Kontrola neprihlasen
    Chybova hlaska - prazdny mail

Prihlaseni - mail OK, heslo prazdne
    Prihlaseni       giyipem264@v1zw.com        ${PRAZDNY}
    Kontrola neprihlasen
    Chybova hlaska - prazdne heslo

#Registrace na kurz
Registrace na kurz
    Prihlaseni      giyipem264@v1zw.com    tajnenovak
    Registrace na kurz cislo 3      10669990    +420607580000


*** Keywords ***

Prihlaseni
    [Arguments]     ${USER1_EMAIL}                          ${USER1_PASSWORD}
    New Browser     chromium        headless=false
    New Page        http://testovani.kitner.cz/login
    Type Text       data-test=email_input                   ${USER1_EMAIL}
    Type Text       data-testid=password_input              ${USER1_PASSWORD}
    Click           id=login_button

Odhlaseni
    Click           text=Odhlásit se

# Kontroly
Kontrola prihlasen
    Get Text        data-testid=logout_button           ==      Odhlásit se
    Log             Uživatel je přihlášen

Kontrola neprihlasen
    Get Text        data-testid=login_link              ==      Přihlásit se
    Log             Uživatel je odhlašen

# Chybové hlášky
Chybova hlaska - spatne zadany mail nebo heslo
    Get Text        data-testid=email_input_errors      ==      These credentials do not match our records.
    Log             Špatně zadané údaje
Chybova hlaska - prazdny mail
    Get Text        data-testid=email_input_errors      ==      The email field is required.
    Log             Nezadán email

Chybova hlaska - prazdne heslo
    Get Text        data-testid=password_input_errors       ==      The password field is required.
    Log             Nezadáno heslo

# Registrace
Registrace na kurz cislo 3
    [Arguments]         ${ICO}                      ${TELEFON}
    Set Strict Mode     off
    Click               css=[data-testid=course_3] [data-testid=registration_link]
    Click               data-testid=registration_link
    Type Text           data-testid=ico_input       ${ICO}
    Type Text           data-testid=phone_input     ${TELEFON}
    Click               data-testid=registration_link
    Wait For Alert      Accept
    Get Text            data-testid=courses_title       ==      Mé zapsané kurzy

# Ta registrace na kurz hodně bolela takhle v půl druhé v noci :D


