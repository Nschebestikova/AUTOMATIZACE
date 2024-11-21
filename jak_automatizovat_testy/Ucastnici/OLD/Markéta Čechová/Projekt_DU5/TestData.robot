#
# Tento soubor obsahuje všechny Testovací Data
#


*** Variables ***
#uživatel
${USER1_EMAIL}                  giyipem264@v1zw.com
${USER1_PASSWORD}               tajnenovak
${USER1_INVALID_EMAIL}          novak@v1zw.com
${USER1_INVALID_PASSWORD}       AAAAAAAAAAAAA

#registrace na kurz
${ICO}                          10669990
${TELEFON}                      +420607580000

#Strings
${TEXT_MainTitle}               Testování - přihlášení
${TEXT_Prihlasit}               Přihlásit se
${TEXT_Ohlasit}                 Odhlásit se
${TEXT_Registrace}              Mé zapsané kurzy

#Error strings
${ERROR_TEXT_IncorrectEmailOrPwd}   These credentials do not match our records.
${ERROR_TEXT_EmptyPwd}              The password field is required.
${ERROR_TEXT_EmptyEmail}            The email field is required.

#SELEKTORY pro Login
${SEL_LoginLink}            data-testid=login_link
${SEL_LoginErrorTxt}        data-testid=email_input_errors
${SEL_LoginIncorrectEmail}  data-test=email_input_err ors
${SEL_LoginIncorrectPwd}    data-testid=password_input_errors
${SEL_LoginFormEmail}       data-test=email_input
${SEL_LoginFormPwd}         data-testid=password_input
${SEL_UserLoginBtn}         data-testid=login_button
${SEL_UserLogoutBtn}        data-testid=logout_button

#SELEKTORY pro Header
${SEL_Menu}                 data-testid=navigation_container

#SELEKTORY pro registraci
${REG_CourseInfoBtn}        css=[data-testid=course_3] [data-testid=registration_link]
${REG_RegistrationBtn}      data-testid=registration_link
${REG_IcoInput}             data-testid=ico_input
${REG_TelInput}             data-testid=phone_input
${REG_Confirmation}         data-testid=courses_title