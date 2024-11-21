

*** Variables ***


${URL}                  https://www.make.com/en/login
${prohlizec}            chromium
${TIMEOUT_BROWSER}      3 s


#uživatel
${USER_EMAIL}                   dedalebeda753@gmail.com
${USER_PASSWORD}                Dedalebeda_123
${USER_INVALID_EMAIL}           novak@v1zw.com
${USER_INVALID_PASSWORD}        AAAAAAAAAAAAA

#SELEKTORY pro Login
${SEL_LoginFormEmail}           css=[class=form-control][name=email]
${SEL_LoginFormPwd}             css=[class=form-control][name=password]
${SEL_UserLoginBtn}             css=[type=submit]
${SEL_LogoutAvatar}             css=[class=avatar]
${SEL_LogoutBtn}                text=Odhlásit