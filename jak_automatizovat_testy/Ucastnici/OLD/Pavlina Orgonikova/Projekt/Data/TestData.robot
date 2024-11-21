*** Variables ***

#selectors for login
${SEL_LoginEmail}           wavif64820@darkse.com
${SEL_LoginPassword}        Nezname246
${SEL_LoginLink}            data-test=login_link
${SEL_LoginBtn}             data-test=login_button
${SEL_UserLogoutBtn}        data-test=logout_button
${SEL_LoginEmailForm}       data-test=email_input
${SEL_LoginPasswordForm}    data-test=password_input
${SEL_RegistrationLink}     data-test=registration_link
${SEL_CourseName}           data-test=course_name
${SEL_LoginWrongInput}      data-test=email_input_errors
${SEL_LoginErrorPassword}   data-test=password_input_errors
${SEL_Zajem}                data-test=registration_prompt
${SEL_RegisterBtn}          data-test=register_button
${SEL_UserLogoutBtn}        data-test=logout_button

#strings
${TEXT_MainTitle}          Testování - Přehled kurzů
${TEXT_Zajem}              "Máte zájem o naše kurzy?"
${TEXT_Prihlasit}           Přihlásit se
${TEXT_Odhlasit}             Odhlásit se
${TEXT_Registrovat}         Registrovat
${TEXT_TitleRegistrace}     Testování - registrace

#error messages
${ERROR_WrongCredentials}     These credentials do not match our records.        #wrong email or password or both
${ERROR_EmptyEmail}           The email field is required.                       #empty email field
${ERROR_EmptyPassword}        The password field is required.                    #empty password field

#navigation header menu
${SEL_Menu}                 data-test=navigation_container