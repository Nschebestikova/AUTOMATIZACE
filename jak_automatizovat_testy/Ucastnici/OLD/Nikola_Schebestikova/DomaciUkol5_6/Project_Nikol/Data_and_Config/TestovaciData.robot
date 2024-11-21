
*** Variables ***
#uživatel - login INPUTS / THE MAIN INPUTS
${URL}                  http://testovani.kitner.cz/courses
${Email}                nikolaschebestikova@gmail.com
${Password}             Testerka123
${badPassword}          Testerka321
${JePrihlasen}          yes

${pageURL}              http://testovani.kitner.cz/courses
${pageURL2}             http://testovani.kitner.cz/courses/
${name}                 NikolaTesterka

#Strings CHECKING - ověření textací NA WEBU
${TEXT_Title}            Testování - Přehled kurzů
${TEXT_Prihlasit}        Přihlásit se
${TEXT_Odhlasit}         Odhlásit se

#SELEKTORY pro Login OBECNÉ
${SEL_LoginLink}            data-test=login_link
${SEL_LoginErrorTxt}        data-test=email_input_errors
${SEL_LoginIncorrectEmail}  data-test=email_input_errors
${SEL_LoginIncorrectPwd}    data-test=password_input_errors

#SELEKTORY - LOGINY A INPUTY A LOGOUTY
${SEL_EmailInput}           data-test=email_input
${SEL_PasswprdInput}        data-test=password_input
${SEL_LoginFormPwd}         data-test=password_input
${SEL_UserLoginbattonn}     data-test=login_button
${SEL_UserLogoutBatton}     data-test=logout_button

# SELEKTORY INPUTY LOGIN A REGISTRACE
${SEL_LoginNameInput}       data-test=name_input
${SEL_PasswordAgain}        data-test=password_again_input
${SEL_RegistrButton}        data-test=register_button

#SELEKTORY PRO KURZY
${SEL_CourseName}           css=[data-test=course_name]

#SELEKTORY pro Header - pro hlavičku webu
${SEL_Menu}                 data-test=navigation_container


#lépe do testů zapracovat selektory