#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#uživatel
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak

#Strings
${TEXT_MainTitle}                   Testování - Přehled kurzů
${TEXT_Prihlasit}                   Přihlásit se
${TEXT_Ohlasit}                     Odhlásit se

#Error strings
${ERROR_TEXT_IncorrectEmailOrPwd}   These credentials do not match our records.
${ERROR_TEXT_EmptyPwd}              The password field is required.
${ERROR_TEXT_EmptyEmail}            The email field is required.

#SELEKTORY pro Login
${SEL_LoginLink}            data-test=login_link
${SEL_LoginErrorTxt}        data-test=email_input_errors
${SEL_LoginIncorrectEmail}  data-test=email_input_errors
${SEL_LoginIncorrectPwd}    data-test=password_input_errors
${SEL_LoginFormEmail}       data-test=email_input
${SEL_LoginFormPwd}         data-test=password_input
${SEL_UserLoginBtn}         data-test=login_button
${SEL_UserLogoutBtn}        data-test=logout_button

#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat




