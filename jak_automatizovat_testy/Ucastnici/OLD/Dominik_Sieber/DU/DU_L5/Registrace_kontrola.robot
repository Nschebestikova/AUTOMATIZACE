*** Settings ***
Library  Browser
Documentation   Cvičení které mění umístění testovacích dat. Z místa přímo v testech na společný soubor
...             s testovacími daty, který je uložený v adresáři Data_and_Config

Resource            C:/Users/Užívatel/PycharmProjects/jak_automatizovat_testy/Ucastnici/Aktualni/Dominik_Sieber/DU/Project/Data_Config/Configuration.robot
Resource            C:/Users/Užívatel/PycharmProjects/jak_automatizovat_testy/Ucastnici/Aktualni/Dominik_Sieber/DU/Project/Data_Config/TestData.robot

*** Variables ***
# global vairable

*** Test Cases ***
#Registrace s korektními udaji
# je nutne dodelat refistraci kontrolu/cisteni
Registrace - success
    Zadaní registrace           ${user_name_5}    ${user_mail_5}    ${user_pass_5}      ${user_pass_5}          ${TEXT_registr_res_registered}
#Registrace s krátkym heslem
Registrace - fail - kratke pass
    Zadaní registrace           ${user_name_6}    ${user_mail_6}    ${user_pass_6}      ${user_pass_6}          ${TEXT_registr_res_notRegistered}
    Kratke pass
#Registrace s pouzitym mailem
Registrace - fail - email taken
    Zadaní registrace           ${user_name_7}    ${user_mail_7}    ${user_pass_7}      ${user_pass_7}          ${TEXT_registr_res_notRegistered}
    Email error
#Registrace se spatnym overenim hesla
Registrace - fail - spatne pass
    Zadaní registrace           ${user_name_8}    ${user_mail_8}    ${user_pass_8}      ${user_worng_pass_8}    ${TEXT_registr_res_notRegistered}
    Spatne pass

#Registrace s prazdnym udajem
Registrace - blank mail
    Zadaní registrace           ${user_name_9}    ${user_mail_9}    ${user_pass_9}      ${user_pass_9}          ${TEXT_registr_res_notRegistered}
    Blank mail error

#Registrace - TBD

*** Keywords ***
Zadaní registrace
    [Arguments]     ${name}     ${email}    ${password}     ${pass_verific}    ${registered}
    Log             ${name}
    Log             ${email}
    Log             ${password}

    New Browser         chromium    headless=true
    New Context         viewport={'width': 1920, 'height': 1080}
    New Page            ${URL}
    Click               ${SEL_button_login_link}
    Log                 Login macknut
    Get Url             *=  login
    Log                 Url obsahuje "kitner.cz/login"
    Click               ${SEL_login_form_register_link}
    Get Url             *=  kitner.cz/register
    Log                 Registracni form nacten
    Fill Text           ${SEL_register_form_name_input}                ${name}
    Fill Text           ${SEL_register_form_mail_input}                ${email}
    Fill Text           ${SEL_register_form_pass_input}                ${password}
    Fill Text           ${SEL_register_form_pass_verif_input}          ${pass_verific}
    Click               ${SEL_register_form_button_register}
    Log                 Kliknuto na registraci po vyplneni udaju!
    
    IF    "${registered}" == "${TEXT_registr_res_notRegistered}"
        Get Url     *=      kitner.cz/register
        Take Screenshot
    ELSE
        Get Text    data-test=home_section      ==      Vítej uživateli ${name}!
        Log         Domaci stranka
        Take Screenshot
    END

 Email error
    Get Text    ${SEL_error_register_used_mail}             ==       ${ErrorText_register_used_mail}
    Log         Email je jiz pouzit
    Take Screenshot

 Blank mail error
    Get Text    ${SEL_error_register_blank_mail}            ==       ${ErrorText_register_blank_mail}
    Log         Polozka email je povinne
    Take Screenshot

 Kratke pass
    Get Text    ${SEL_error_register_short_pass}            ==       ${ErrorText_register_short_pass}
    Log         Heslo musí byt min 8 znaku
    Take Screenshot

 Spatne pass
    Get Text    ${SEL_error_register_wrong_pass_match}      ==       ${ErrorText_register_wrong_pass_match}
    Log         Heslo nesouhlasi
    Take Screenshot