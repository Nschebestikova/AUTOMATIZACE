*** Variables ***

#Configuration
${URL}                  http://testovani.kitner.cz/courses
${API_URL}              http://testovani.kitner.cz/
${PORT}                 80
${APP_REG}              regkurz/formsave.php
${APP_LOG}              login_app/userauth.php
${URLAPP_REG}           ${API_URL}${APP_REG}
${URLAPP_LOG}           ${API_URL}${APP_LOG}


${timeBetweenClicks}    100ms
${timeBeteweenChecks}   200ms

#mohu napsat "1 s", pokud jen cislo, pocita se aut jako s
${SleepBeforeTest}      1
${tcTimeoutRobotKW}     2 minutes

    #udaje
${loginCorrect}         test@test.com
${loginCorrPw}          test1234
${loginIncorrPw}        test12345
${loginCorrName}        test

    #textace
${negTestSucc}          Negativni test selhal
${negTestFail}          Negativni test selhal
${userLoggedin}         Uzivatel je prihlasen
${userLoggedout}        Uzivatel je odhlasen
${regUnsucc}            Registrace nebyla uspesna
${regSucc}              Registrace probehla uspesne

${wrongCredLogin}       These credentials do not match our records.
${regMailInUse}         The email has already been taken.

    #textace s diakritikou
${courseSummary}        Testování - Přehled kurzů
${loginText}            Přihlásit se
${logoutText}           Odhlásit se
${courseInterest}       Máte zájem o naše kurzy?
${myProfile}            Můj Profil
${welcomeUser}          Vítej uživateli

#selectors
${SEL_login_link}               data-test=login_link
${SEL_email_input}              data-test=email_input
${SEL_password_input}           data-test=password_input
${SEL_login_button}             data-test=login_button
${SEL_logout_button}            data-test=logout_button
${SEL_courses_profile}          data-test=courses_profile
${SEL_email_input_errors}       data-test=email_input_errors
${SEL_home_section}             data-test=home_section
${SEL_register_link}            data-test=register_link
${SEL_course_name}              data-test=course_name
${SEL_name_input}               data-test=name_input
${SEL_password_again_input}     data-test=password_again_input
${SEL_register_button}          data-test=register_button


#json

${json_cv62_registrace_ok}                                      {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${json_cv62_registrace neexistujici kurz - neg}                 {"targetid":"","kurz":"4","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123125","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json_cv62_registrace bez volby kurzu}                         {"targetid":"","kurz":"2","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json_cv62_registrace bez volby kurzu - neg}                   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json_cv62_registrace moc dlouhe cislo}                        {"targetid":"","kurz":"1","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"6081231231","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json_cv62_registrace moc kratke cislo}                        {"targetid":"","kurz":"1","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"60812312","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json_cv62_registrace moc kratke cislo - neg}                  {"targetid":"","kurz":"1","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"60812312","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json_cv62_registrace bez vyplneho jmena}                      {"targetid":"","kurz":"1","name":"","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123125","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json_cv62_registrace nesouhlas}                               {"targetid":"","kurz":"1","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123125","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":false}
${json_cv62_registrace bez povinnych - nevyplnene}              {"targetid":"","kurz":"","name":"","surname":"","email":"","phone":"","person":"","address":"","ico":"","count":"","comment":null,"souhlas":true}
${json_cv62_registrace bez povinnych - bez parametru}           {"targetid":"","comment":null,"souhlas":true}
${json_cv62_registrace bez nepovinnych}                         {"targetid":"","kurz":"1","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123125","person":"fyz","address":"Brno","ico":"234563234","count":"1"}
${json_cv62_registrace JSON chyby - chybejci , : ""}            {"targetid":"""kurz":"1","name":"Jan","surname""Svoboda","email":"jan.novak@abc.cz",phone:"608123125","person":fyz,"address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":false}
${json_cv62_registrace JSON chyby - chybne nazvy parametru}     {"targetid":"","kuurz":"1","name":"Jan","surname":"Svoboda","mail":"jan.novak@abc.cz","phone":"608123125","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"GDPR":true}

${json_cv62_login_ok}                                {"username":"admin","password":"tajneadmin","useragent":"Chrome"}
${json_cv62_login prazdne hodnoty}                   {"username":"","password":"","useragent":""}
${json_cv62_login spatne heslo}                      {"username":"admin","password":"tajneadmin1","useragent":"Chrome"}
${json_cv62_login spatne parametry}                  {"usrname":"admin","pasword":"tajneadmin1","useragent":"Chrome","test":"test"}
${json_cv62_login chybejici parametry}               {"usrname":"admin","pasword":"tajneadmin1"}


