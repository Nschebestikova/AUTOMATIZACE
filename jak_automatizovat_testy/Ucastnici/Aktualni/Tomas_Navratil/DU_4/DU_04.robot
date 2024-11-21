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
${TITLE1}                           Testování - přihlášení
${TITLE2}                           Testování - Přehled kurzů

*** Test Cases ***

Test01 - Prihlaseni s kontrolou - mail no ok
                    #Prihlaseni - test s kontrolou   bez vyuziti argumentu
                    Login                   hasdfrt@avbnui.cz           ${USER1_PASSWORD}
                    Kontrola - Uzivatel neni prihlasen

Test02 - Prihlaseni s kontrolou - bad password
                    Login                   ${USER1_EMAIL}              ouiuopyp
                    Kontrola - Uzivatel neni prihlasen
Test03 - Prihlaseni s kontrolou - success
                    Login                   ${USER1_EMAIL}              ${USER1_PASSWORD}
                    Kontrola - Uzivatel je prihlasen

Test04 - Odhlaseni s kontrolou
                    Login                   ${USER1_EMAIL}              ${USER1_PASSWORD}
                    Logout
                    Kontrola - Uzivatel neni prihlasen

Test05 - Registrace na kurs cislo 4
                    Login                   ${USER1_EMAIL}              ${USER1_PASSWORD}   #prihlaseni
                    Kontrola - Uzivatel je prihlasen                                        #overeni, ze je uzivatel prihlasen
                    #nejprve zjistit kolik je na webu kurzů
     ${number_courses}  Pocet kurzu             ${URL2}

     IF             ${number_courses} > 3  #Jestlize kurzu je na webu alespon 4 a vice, pak mohu pokracovat s prihlasenim na kurs c4
                    ${JmenoKurzu} =      Get Text               data-test=course_name >> nth=4    #Registrace na kurs cislo 4 - Webinar
                    Log To Console       KURZ: ${JmenoKurzu}
                    Log                  KURZ: ${JmenoKurzu}
                    Registration_on_course
     END





*** Keywords ***
Otevreni stranky            #otevreni tabu
                [Arguments]          ${noveURL}       ${newTITLE}
                New Page             ${noveURL}
                Get Title  ==        ${newTITLE}       #overeni, ze se stranka otevrela

Login                       #Prihlaseni
                [Arguments]             ${email}                            ${password}
                New Browser             chromium                            headless=false    #otevrit prohlizec
                Otevreni stranky        ${URL1}                             ${TITLE1}
                Type Text               data-test=email_input               ${email}          #vlozit text - email
                Type Text               data-test=password_input            ${password}          #vlozit text - heslo
                Log                     User email is: ${email}
                Log                     User password is: ${password}
                Take Screenshot                                                #screenshot login page
                Click                   id=login_button                        #kliknout na tlacitko "Přihlásit"
                Sleep                   1s                                     #pockat chvili
                Take Screenshot                                                #screenshot courses page

Logout                      #Odhlaseni
                Get Url                 ==                                  ${URL2}           #kontrola - spravna stranka ${URL2}
                Get Title               ==                                  ${TITLE2}          #kontrola, logout se vola ze spravne stranky
                Take Screenshot                                                               #screenshot login page
                Click                   data-test=logout_button                               #kliknout na tlacitko "Odhlásit se"
                Sleep                   1s                                     #pockat chvili
                Take Screenshot                                                #screenshot


Kontrola - Uzivatel je prihlasen      #kontrola - prihlaseni je aktivni
                 Get Text                data-test=logout_button  ==         ${LOGOUT_TEXT}    #nacist logout text pomoci lokatoru data-test
                 Get Url                                          ==         ${URL2}           #overeni spravne stranky ${URL2}
                 Take Screenshot

Kontrola - Uzivatel neni prihlasen    #kontrola - prihlaseni neni aktivni
                 Get Text                data-test=login_link    ==          ${LOGIN_TEXT}
                 Take Screenshot



Pocet kurzu
                [Arguments]          ${newURL}
                Go To                ${newURL}
                            # Je třeba počkat až se všechny kurzy nahrají, to se zajistí čekáním na element na konci stránky
                Get Text             "Máte zájem o naše kurzy?"

                            # spočítá kolik je tam kurzu podle počtu výskytu elementů s atributem data-test=course_name
    ${NumCourses} =      Get Element Count           data-test=course_name
                         Log To Console       ${NumCourses}
                         [Return]             ${NumCourses}


Registration_on_course  # registrace na kurs č.4

                ${old_mode} =      Set Strict Mode    False                    # Neselže, pokud selektor ukazuje více prvků
                Click              css=[data-test=course_buttons]  >> nth=4
                Take Screenshot
                Set Strict Mode    ${old_mode}
