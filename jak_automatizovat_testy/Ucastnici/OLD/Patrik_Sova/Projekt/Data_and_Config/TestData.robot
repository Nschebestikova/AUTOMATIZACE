#
# Tento soubor obsahuje všechny Testovací Data


*** Variables ***


#uživatel
${USER1_NAME_Wrong_1}                expert
${USER1_Password_Correct_1}          Password123
${USER1_Password_Wrong_1}            123456PAS
${USER1_NAME_Correct_1}              student

#Strings
${TEXT_MainTitle}                   Test Login | Practice Test Automation
${TEXT_Success_Login}               Logged In Successfully
${TEXT_To_Console_1}                !!!Je prihlasen!!!
${TEXT_To_Console_2}                !!!Neni prihlasen!!!
${TEXT_other}                       Submit
${TEXT_Invalid_Username}            Your username is invalid!
${TEXT_Invalid_Password}            Your password is invalid!


#SELEKTORY id
${SEL_username_id}             id=username
${SEL_password_id}             id=password
${SEL_submit_id}               id=submit

#SELEKTORY css
${SEL_post_title_css}           css=[class=post-title]
${SEL_submit_css}               css=[id=submit]
${SEL_logout_button_css}        css=.wp-block-button__link.has-text-color.has-background.has-very-dark-gray-background-color

#SELEKTORY Xpath
${SEL_error_xpath}              //*[@id="error"]