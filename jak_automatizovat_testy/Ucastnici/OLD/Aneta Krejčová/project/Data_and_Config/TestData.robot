#
# Tento soubor obsahuje všechny Testovací Data
#
*** Variables ***
${URL}      http://testovani.kitner.cz/courses
# uživatel
${SPRAVNY_MAIL}         giyipem264@v1zw.com
${SPRAVNE_HESLO}        tajnenovak

#data špatné přihlášení
${SPATNY_MAIL}          chyba@zk.com
${SPATNY_MAIL_ZAVINAC}  giyipem264v1zw.com
${SPATNY_MAIL_COM}      giyipem264@v1zw.
${SPATNE_HESLO}         chyba
${SPATNE_HESLO_MEZERA}  tajne novak
${SPATNY_MAIL_BEZTECKY}  giyipem264@v1zwcom

#řetězce
${NEPRIHLASI_SE}        Neprihlasi se
${PRIHLASI_SE}          Přihlásit se
${ODHLASI_SE}           Odhlásit se
${NEODHLASI_SE}          Neodhlasit se
${TITULEK_STRANKY}       Testování - Přehled kurzů
${IC}                               45274649
${TELEFON}                          +420111111111

#Chybové hlášky
${ERROR_TEXT_IncorrectEmailOrPwd}   These credentials do not match our records.
${ERROR_TEXT_EmptyPwd}              The password field is required.
${ERROR_TEXT_EmptyEmail}            The email field is required.

#selectory přihlášení odhlášení
${SELECTOR_PRIHLASENI}    data-test=login_link
${SELECTOR_PRIHLASENI_FORMULAR}    data-test=login_button
${SELECTOR_ODHLASENI}    data-test=logout_button
${SELECTOR_MAIL}           data-test=email_input
${SELECTOR_HESLO}           data-test=password_input

#selectory registrace do kurzu
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
${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}    css=[data-test=registration_link] >> nth=0

#SELEKTORY pro Header
${SEL_Menu}                 data-test=navigation_container

#API
${url2}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url2}${app}