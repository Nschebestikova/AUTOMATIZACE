#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#uživatel
${USER1_EMAIL}                   giyipem264@v1zw.com
${USER1_PASSWORD}                tajnenovak
${WRONG_EMAIL}                   netocnaklara@sdifjasf.com
${WRONG_PASSWORD}                chyba
${REGISTRATION_NICKNAME}         KlaraNeto
${REGISTRATION_EMAIL}            netzklar@wizz123.com
${REGISTRATION_PASSWORD}         tajnenovak1
${REGISTRATION_WRONG_ PASSWORD}  netocnaklara

#Strings
${TEXT_MainTitle}                   Testování - Přehled kurzů
${TEXT_Prihlasit}                   Přihlásit se
${TEXT_Odhlasit}                    Odhlásit se
${TEXT_Registrovat}                 Registrovat

#Error strings
${ERROR_TEXT_IncorrectEmailOrPwd}   These credentials do not match our records.
${ERROR_TEXT_EmptyPwd}              The password field is required.
${ERROR_TEXT_EmptyEmail}            The email field is required.

#SELEKTORY pro Login
${SEL_LoginLink}            data-test=login_link
${SEL_LoginErrorTxt}        data-test=email_input_errors
${SEL_LoginIncorrectEmail}  data-test=email_input_errors
${SEL_LoginIncorrectPwd}    data-test=password_input_errors
${SEL_FormEmail}            data-test=email_input
${SEL_FormPwd}              data-test=password_input
${SEL_FormAgainPwd}         data-test=password_again_input
${SEL_UserLoginBtn}         data-test=login_button
${SEL_UserLogoutBtn}        data-test=logout_button
${SEL_RegisterLink}         data-test=register_link
${SEL_RegisterText}         data-test=register_text
${SEL_RegisterFormName}     data-test=name_input
${SEL_RegisterButton}       data-test=register_button

#SELEKTORY pro Header
${SEL_Menu}                 data-test=navigation_container




