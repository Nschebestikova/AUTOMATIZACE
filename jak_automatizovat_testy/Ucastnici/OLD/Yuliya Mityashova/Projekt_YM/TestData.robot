
*** Variables ***
${USER1_EMAIL}                      giyipem264@v1zw.com
${USER1_PASSWORD}                   tajnenovak
${URL}                              http://testovani.kitner.cz/login
${INVALID_PASSWORD}                 password
${INVALID_EMAIL}                    test@test.com
${ICO}                              10669990
${PHONE}                            775056071

#Strings
${TEXT_MainTitle}                   Testování - Přehled kurzů
${TEXT_Prihlasit}                   Přihlásit se
${TEXT_Ohlasit}                     Odhlásit se
${TEXT_CourseName}                  Jak ovládat GIT
${TEXT_Registration}                Registrace kurzu
${TEXT_MyCourses}                   Mé zapsané kurzy


#Error messages
${ERROR_TEXT_IncorrectEmailOrPwd}   These credentials do not match our records.


#Login selectors
${SEL_LoginLink}                    data-test=login_link
${SEL_LoginErrorTxt}                data-test=email_input_errors
${SEL_LoginIncorrectEmail}          data-test=email_input_errors
${SEL_LoginIncorrectPwd}            data-test=password_input_errors
${SEL_LoginFormEmail}               data-test=email_input
${SEL_LoginFormPwd}                 data-test=password_input
${SEL_UserLoginBtn}                 data-test=login_button
${SEL_UserLogoutBtn}                data-test=logout_button

#Registration sleectors
${SEL_UserRegistrLink}              data-test=registration_link
${SEL_RegistrCourseName}            data-test=course_name
${SEL_CourseRegistrTitle}           data-test=registration_title
${SEL_CourseTitle}                  data-test=course_title
${SEL_UserICO}                      data-test=ico_input
${SEL_UserPhone}                    data-test=phone_input

#Header selectors
${SEL_HeaderLogo}                   id=logo
${SEL_SearchGlobal}                 id=searchGlobal
${SEL_BtnSearchGlobal}              text=Hledat




