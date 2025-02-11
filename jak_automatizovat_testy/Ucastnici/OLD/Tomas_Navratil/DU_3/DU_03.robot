*** Settings ***
Library  Browser

*** Variables ***
${URL1}                             http://testovani.kitner.cz/login
${URL2}                             http://testovani.kitner.cz/courses

${USER1_NAME}                       Michal Novák
${USER1_EMAIL}                      giyipem264@v1zw.com
${USER1_PASSWORD}                   tajnenovak
${LOGOUT_TEXT}                      Odhlásit se
${LOGIN_TEXT}                       Přihlásit se
${TITLE}                            Testování - přihlášení

*** Test Cases ***
Test1 - Prihlaseni bad login
                Login                   gtdfsff@gdfsrt.cz           ${USER1_PASSWORD}
                Uzivatel neni prihlasen
Test2 - Prihlaseni bad password
                Login                   ${USER1_EMAIL}              jklm
                Uzivatel neni prihlasen
Test3 - Prihlaseni success
                Login                   ${USER1_EMAIL}              ${USER1_PASSWORD}
                Uzivatel je prihlasen


*** Keywords ***
Login
                [Arguments]             ${email}                            ${password}
                New Browser             chromium                            headless=false    #otevrit prohlizec
                New Page                ${URL1}
                Get Title               ==                                  ${TITLE}          #overeni, ze se stranka otevrela
                Type Text               data-test=email_input               ${email}          #vlozit text - email
                Type Text               data-test=password_input            ${password}          #vlozit text - heslo
                Log                     User email is: ${email}
                Log                     User password is: ${password}
                Take Screenshot                                                #screenshot login page
                click                   id=login_button                        #kliknout na tlacitko "Přihlásit", zde je jiny typ locatoru - id

                Sleep                   1s                                     #pockat chvili
                Take Screenshot                                                #screenshot courses page

Uzivatel je prihlasen
                 Get Text                data-test=logout_button  ==         ${LOGOUT_TEXT}    #nacist logout text pomoci lokatoru data-test
                 Get Url                                          ==         ${URL2}           #overeni spravne stranky ${URL2}
                 Take Screenshot

Uzivatel neni prihlasen
                 Get Text                data-test=login_link    ==          ${LOGIN_TEXT}
                 Take Screenshot




