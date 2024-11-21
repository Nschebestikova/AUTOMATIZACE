
*** Variables ***

# server
${TITLE}                Andrea Shop

# user
${EMAIL}                timotejpap@centrum.sk
${PASSWORD}             1tragikomiX
${BAD_EMAIL}            paptimotej@gmail.com
${BAD_PASSWORD}         1Tragikomiks

# error texts
${ERROR_EMAIL_TEXT}     text="Pole E-mail alebo prihlasovacie meno je povinné."
${ERROR_PASSWORD_TEXT}  text="Pole Heslo je povinné."

# locators Login
${SEL_COOKIE}           css=.reject-all
${SEL_ELEMENT_STATE}    css=.login
${SEL_LOGIN_LINK}       css=.login
${SEL_LOGIN_EMAIL}      id=edit-name
${SEL_LOGIN_PSW}        css=#edit-pass
${SEL_SUBMIT}           id=edit-submit
${SEL_LOGOUT_LINK}      css=.logout
${SEL_MENU}             css=.content

