*** Settings ***
Library  Browser


*** Variables ***
${URL}                      http://testovani.kitner.cz
${URL_login}                /login
${URL_courses}              /courses
${prohlizec}                chromium

${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak

${TYPING_DELAY}             60 ms


*** Test Cases ***
# Testy na prihlaseni
# Pozitivni
Uspesny Login - spravne heslo + spravne jmeno
    Login       ${USER1_EMAIL}     ${USER1_PASSWORD}
    Prihlasen

# Negativni
Neuspesny Login - spatne jemno
    Login       fffggg@hhh.com     ${USER1_PASSWORD}
    Neprihlasen
    Chybova hlaska neplatne udaje

Neuspesny Login - spatne heslo
    Login      ${USER1_EMAIL}      budulinek
    Neprihlasen
    Chybova hlaska neplatne udaje
    # hlaska u emailu, ne u hesla

Neuspesny Login - spatne jmeno + spatne heslo
    Login      fffggg@hhh.com      budulinek
    Neprihlasen
    Chybova hlaska neplatne udaje

Neuspesny Login - zadne jmeno + zadne heslo
    Login      ${EMPTY}            ${EMPTY}
    Neprihlasen
    Chybova hlaska prazdny email
    Chybova hlaska prazdne heslo

Neuspesny Login - dlouhy email (za zavinacem 70 znaku)
    Login      jah@fffggghhhjfffggghhhjfffggghhhjfffggghhhjfffggghhhjfffggghhhjfffggghhhj.com      ${USER1_PASSWORD}
    Neprihlasen
    Chybova hlaska neplatne udaje
    # Informacni hlaska: "Zadejte prosím e-mailovou adresu."

# Test na odhlaseni
Uspesny Logout
    Login       ${USER1_EMAIL}     ${USER1_PASSWORD}
    Prihlasen
    Logout
    Neprihlasen


*** Keywords ***
#KS na prihlaseni
Login
  [Arguments]          ${Email}            ${Heslo}

   New Browser        browser=${prohlizec}  headless=False
   New Page           ${URL}${URL_login}
   Get Title  ==      Testování - přihlášení

   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}  delay=${TYPING_DELAY}
   Type Text        data-test=password_input         ${Heslo}  delay=${TYPING_DELAY}
   Click            data-test=login_button

#KS na odhlaseni
Logout
   Click            data-test=logout_button
   Get Text         data-test=login_link

# Kontrola prihlaseni/neprihlaseni
Prihlasen
    Get Text        data-test=logout_button       ==       Odhlásit se
Neprihlasen
    Get Text        data-test=login_link          ==       Přihlásit se

# Kontrola chybove hlasky
Chybova hlaska neplatne udaje
       Get Text   data-test=email_input_errors  *=  These credentials do not match our records.
Chybova hlaska prazdny email
       Get Text   data-test=email_input_errors  *=  The email field is required.
Chybova hlaska prazdne heslo
       Get Text   data-test=password_input_errors  *=  The password field is required.



# REGISTRACE PŘIHLÁŠENÉHO UŽIVATELE NA KURZ
*** Test Cases ***
# Testy na registraci
# Pozitivni
Uspesna registrace kurzu - spravne IC + spravne telefon
    Login       ${USER1_EMAIL}     ${USER1_PASSWORD}
    Prihlasen
    Registration  25596641  555666777
    Registrovan

# Negativni
Neuspesna registrace kurzu - spatne IC + spravny telefon
    Login       ${USER1_EMAIL}     ${USER1_PASSWORD}
    Prihlasen
    Registration  12345678  123456789
    Neregistrovan
    Chybova hlaska neplatne ICO

Neuspesna registrace kurzu - spravne IC + spatny telefon
    Login       ${USER1_EMAIL}     ${USER1_PASSWORD}
    Prihlasen
    Registration  25596641  12345678
    Neregistrovan
    Chybova hlaska neplatne telefonni cislo


*** Keywords ***
# Klicova slova na registraci
Registration
    [Arguments]  ${ICO}  ${telefon}
    Set Strict Mode    off
    Click       data-test=registration_link
    Click       data-test=registration_link
    Get Text    data-test=registration_title  ==  Registrace kurzu
    Click       data-test=ico_input
    Type Text   data-test=ico_input            ${ICO}        delay=${TYPING_DELAY}
    Click       data-test=phone_input
    Type Text   data-test=phone_input          ${telefon}   delay=${TYPING_DELAY}
    Click       data-test=registration_link

# Kontrola Registration
Registrovan
    Get Text        data-test=courses_title              ==       Mé zapsané kurzy
Neregistrovan
    Get Text        data-test=registration_title         ==       Registrace kurzu

Chybova hlaska neplatne ICO
    Get Text    data-test=ico_error  ==  Neplatné IČO
Chybova hlaska neplatne telefonni cislo
    Get Text    data-test=phone_error  ==  Telefonní číslo musí obsahovat alespoň 9 číslic
