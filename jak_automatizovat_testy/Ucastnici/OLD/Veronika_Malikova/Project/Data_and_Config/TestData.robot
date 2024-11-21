#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#URLs
${url}              http://testovani.kitner.cz/
${app}              regkurz/formsave.php
${app_login}        /login_app/userauth.php
${urlapp}           ${url}${app}
${urlapp_login}     ${url}${app_login}

#useragents
${useragent}                Chrome 101.0.4951.67
${useragent_empty}          null

#uživatel
${user}                     admin
${special_char}             @
${user_empty}               null
${password}                 tajneadmin
${password_empty}           null
${USER1_NAME}               ŽelvíNinja
${USER1_EMAIL}              xameja1700+12456789@ubinert.com
${USER1_PASSWORD}           silneheslo
${user_too_long}            adminadminadminadminadminadminadminadminadminadmin
${password_too_long}        tajneadmintajneadmintajneadmintajneadmintajneadmin

#Strings
${TEXT_MainTitle}                   Testování - Přehled kurzů
${TEXT_Prihlasit}                   Přihlásit se
${TEXT_Odhlasit}                    Odhlásit se
${LOG_RegistrationSuccess}          Uživatel byl registrován.
${LOG_RegistrationUnsuccess}        Uživatel nebyl registrován.
${TEXT_Registrovat}                 Registrovat
${LOG_LoginSuccess}                 Uživatel byl přihlášen.
${LOG_LoginUnsuccess}               Uživatel nebyl přihlášen.
${LOG_LogoutSuccess}                Uživatel byl odhlášen.
${LOG_LogoutUnsuccess}              Uživatel nebyl odhlášen.

#SELEKTORY pro Login
${SEL_LoginLink}                data-testid=login_link
${SEL_RegisterLink}             data-testid=register_link
${SEL_RegisterText}             data-testid=register_text
${SEL_RegisterFormName}         data-testid=name_input
${SEL_RegisterFormEmail}        data-testid=email_input
${SEL_RegisterFormPassword1st}  data-testid=password_input
${SEL_RegisterFormPassword2nd}  data-testid=password_again_input
${SEL_UserRegisterBtn}          data-testid=register_button
${SEL_LoginFormEmail}           data-test=email_input
${SEL_LoginFormPwd}             data-test=password_input
${SEL_UserLoginBtn}             data-test=login_button
${SEL_UserLogoutBtn}            data-test=logout_button

#SELEKTORY pro Header
${SEL_Menu}                     data-test=navigation_container

#API registration JSONs
${correctJSON}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${nameTooLongJSON}  {"targetid":"","kurz":"1","name":"Jan0123456789Jan0123456789Jan0123456789Jan0123456789","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${emptyCourseValueJSON}  {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${emptyCourseKeyJSON}  {"targetid":"","":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${missingQuotationIncorrectJSON}  {"targetid":"",kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${specialCharacterCourseValueJSON}  {"targetid":"","kurz":"@","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${specialCharacterIcoJSON}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"#27232433","count":"1","comment":"nic","souhlas":true}

#API login JSONs
${JSON_login}                               {"username":"${user}","password":"${password}","useragent":"${useragent}"}
${missingQuotationIncorrectJSON_login}      {"password":${password}", "useragent":"${useragent}"}
${emptyUserValueJSON_login}                 {"username":"","password":"${password}","useragent":"${useragent}"}