*** Settings ***
Library  Browser


*** Variables ***
${URL1}                             https://rc.meddiapp.com/
#${URL2}                             http://testovani.kitner.cz/courses

#${USER1_NAME}                       Michal Novák
#${USER1_EMAIL}                      giyipem264@v1zw.com
#${USER1_PASSWORD}                   tajnenovak
#${LOGOUT_TEXT}                      Odhlásit se
#${LOGIN_TEXT}                       Přihlásit se
${TITLE}                            MEDDI app

*** Test Cases ***
Test1
                New Browser             chromium                            headless=false    #otevrit prohlizec
                New Page                ${URL1}
                Get Title               ==                                  ${TITLE}          #overeni, ze se stranka otevrela

                Click                   css=[data-id="frm-regionLanguagePicker-form"]
                Sleep                   1s                                     #pockat chvili

                Click                   id=bs-select-1-8
                Sleep                   5s                                     #pockat chvili

                Take Screenshot                                                #screenshot courses page



