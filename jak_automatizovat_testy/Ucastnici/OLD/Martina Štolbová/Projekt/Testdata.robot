*** Variables ***
#uživatel
${e-mail}    martina.stolbova@seznam.cz
${heslo}     Heslo123
${badheslo}  123
#URL
${URL1}      https://www.zajezdy.cz/
${URL2}      https://www.zajezdy.cz/moje-zajezdy/
#Cookies
${cookies}   id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

#Error strings
${ERROR_TEXT_IncorrectEmailOrPwd}   Bylo špatně zadané uživatelské jméno nebo heslo
${ERROR_TEXT_EmptyPwd}              Bylo špatně zadané uživatelské jméno nebo heslo
${ERROR_TEXT_EmptyEmail}            Bylo špatně zadané uživatelské jméno nebo heslo

#SELEKTORY pro Login
${SEL_LoginLink}            css=.header-collapse >> nth=1
${SEL_LoginErrorTxt}        css=.panel-body bg-danger ng-binding
${SEL_LoginFormEmail}       css=#username
${SEL_LoginFormPwd}         css=#pasword
${SEL_UserLoginBtn}         selector=//button[@type="submit"]
${SEL_UserLogoutBtn}        css=#logout
${SEL_MyAcount}             selector=//*[@class="super-extra-small"]
#SELEKTORY pro hledání
${SEL_Findsomething}                 css=#search-box-locationInput

