*** Settings ***
Library         Browser

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

*** Variables ***
${URL}      http://testovani.kitner.cz/courses
${SPRAVNY_MAIL}         giyipem264@v1zw.com
${SPRAVNE_HESLO}        tajnenovak
${SPATNY_MAIL}          chyba@zk.com
${SPATNY_MAIL_ZAVINAC}  giyipem264v1zw.com
${SPATNY_MAIL_COM}      giyipem264@v1zw.
${SPATNE_HESLO}         chyba
${SPATNE_HESLO_MEZERA}  tajne novak
${NEPRIHLASI_SE}        Neprihlasi se
${PRIHLASI_SE}          Přihlásit se
${SPATNY_MAIL_BEZTECKY}  giyipem264@v1zwcom
${ODHLASI_SE}           Odhlásit se
${NEODHLASI_SE}          Neodhlasit se
${SELECTOR_PRIHLASENI}    data-test=login_link
${SELECTOR_PRIHLASENI_FORMULAR}    data-test=login_button
${SELECTOR_ODHLASENI}    data-test=logout_button
${SELECTOR_MAIL}           data-test=email_input
${SELECTOR_HESLO}           data-test=password_input
${TITULEK_STRANKY}              Testování - Přehled kurzů
${TIMEOUT_BROWSER}              20s
${SELECTOR_REGISTRACE_PRVNI}    css=[data-test=registration_link] >> nth=0
${SELECTOR_REGISTRACE_DRUHY}    css=[data-test=registration_link] >> nth=1
${SELECTOR_REGISTRACE_TRETI}    css=[data-test=registration_link] >> nth=2
${SELECTOR_REGISTRACE_CTVRTY}    css=[data-test=registration_link] >> nth=3
${SELECTOR_REGISTRACE_PATY}    css=[data-test=registration_link] >> nth=4
${SELECTOR_REGISTRACE_SESTY}    css=[data-test=registration_link] >> nth=5
${SELECTOR_REGISTRACE_SEDMY}    css=[data-test=registration_link] >> nth=6
${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}     css=[data-test=registration_link] >> nth=0
${SELECTOR_ICO}                        data-test=ico_input
${SELECTOR_TELEFON}                 data-test=phone_input
${IC}                               45274649
${TELEFON}                          +420111111111
${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}    css=[data-test=registration_link] >> nth=0


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly         ${SPRAVNY_MAIL}        ${SPRAVNE_HESLO}
   Vyhodnoceni testu    ${SELECTOR_ODHLASENI}   ${ODHLASI_SE}
   Take Screenshot
   Odhlaseni_bez_kontroly         ${ODHLASI_SE}
   Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly          ${SPRAVNY_MAIL}         ${SPATNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne heslo mezera - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly          ${SPRAVNY_MAIL}         ${SPATNE_HESLO_MEZERA}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly           ${SPATNY_MAIL}        ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email bez zavinace - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly           ${SPATNY_MAIL_ZAVINAC}         ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email bez com - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly           ${SPATNY_MAIL_COM}          ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email bez tečky - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly          ${SPATNY_MAIL_BEZTECKY}        ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Odhlášení - uspěšné
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
#    Get Text    ${SELECTOR_PRIHLASENI}
Registrace prvni kurz - uspěšná
    Login_bez_kontroly           ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_PRVNI}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace druhy kurz - uspěšná
    Login_bez_kontroly         ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_DRUHY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace treti kurz - uspěšná
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_TRETI}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace ctvrty kurz - uspěšná
    Login_bez_kontroly           ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_CTVRTY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace paty kurz - uspěšná
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_PATY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace sesty kurz - uspěšná
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_SESTY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace sedmy kurz - uspěšná
    Login_bez_kontroly           ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_SEDMY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
*** Keywords ***
Login_bez_kontroly
  [Arguments]      ${Email}            ${Heslo}
  Go to       ${URL}
  Click  ${SELECTOR_PRIHLASENI}
  Type Text        ${SELECTOR_MAIL}           ${Email}
  Type Text        ${SELECTOR_HESLO}         ${Heslo}
  Click            ${SELECTOR_PRIHLASENI_FORMULAR}
  Take Screenshot

Odhlaseni_bez_kontroly
   [Arguments]      ${Text}
   Take Screenshot
    Click  ${SELECTOR_ODHLASENI}
    Take Screenshot

Vyhodnoceni testu
    [Arguments]     ${SELECTOR}             ${VYSLEDEK}
    Get Text     ${SELECTOR}       ==        ${VYSLEDEK}
    Take Screenshot

#Pozitivni test prihlaseni
#    Get Text     ${SELECTOR_ODHLASENI}       ==            ${ODHLASI_SE}
#
#Negativni test prihlaseni
#    Get Text     ${SELECTOR_PRIHLASENI}           ==            ${PRIHLASI_SE}
Registrace na kurz
    [Arguments]     ${SELECTOR_REGISTRACE}
    Set Strict Mode    off
    Click  ${SELECTOR_REGISTRACE}
    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
    Type Text    ${SELECTOR_ICO}    ${IC}
    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
    Take Screenshot
    Set Strict Mode    on

#Registrace prvni kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_PRVNI}
#    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
#    Type Text    ${SELECTOR_ICO}    ${IC}
#    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
#    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace druhy kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_DRUHY}
#    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
#    Type Text    ${SELECTOR_ICO}    ${IC}
#    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
#    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace treti kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_TRETI}
#    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
#    Type Text    ${SELECTOR_ICO}    ${IC}
#    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
#    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace ctvrty kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_CTVRTY}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace paty kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_PATY}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace sesty kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_SESTY}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace sedmy kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_SEDMY}
#    Take Screenshot
#    Set Strict Mode    on

Pred_sadou
    ${b_timeput} =     Set Browser Timeout                 ${TIMEOUT_BROWSER}
    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      ${TITULEK_STRANKY}

Pred_testem
    Go to               ${URL}   #jdi na hlavní stránku

Uklid_po_testu
    Log         Uklid na konci každého testu.
    Go to       ${URL}

Uklid_sada
    Close Browser

#  IF    "${Text}" == "prihlasi se"
#      Get Text     data-test=logout_button       ==            Odhlásit se
#  ELSE
#      Get Text     data-test=login_link          ==            Přihlásit se
#  END