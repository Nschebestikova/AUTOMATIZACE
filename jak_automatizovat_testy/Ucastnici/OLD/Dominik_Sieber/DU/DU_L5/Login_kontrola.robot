*** Settings ***
Library     Browser
Documentation   Cvičení které mění umístění testovacích dat. Z místa přímo v testech na společný soubor
...             s testovacími daty, který je uložený v adresáři Data_and_Config

Suite Setup         Pred_sadou
#Suite Teardown      Uklid_sada

Test Setup          Pred_testem
#Test Teardown       Uklid_po_testu


Resource            C:/Users/Užívatel/PycharmProjects/jak_automatizovat_testy/Ucastnici/Aktualni/Dominik_Sieber/DU/Project/Data_Config/Configuration.robot
Resource            C:/Users/Užívatel/PycharmProjects/jak_automatizovat_testy/Ucastnici/Aktualni/Dominik_Sieber/DU/Project/Data_Config/TestData.robot

#*** Variables ***

*** Test Cases ***
Login - correct entries
    Login success kontrola          ${user_mail_1}      ${user_pass_1}          ${TEXT_logged_in}

Login - wrong password
    Login success kontrola          ${user_mail_2}      ${user_pass_2}          ${TEXT_not_logged_in}
    Error mssge

Login - wrong mail
    Login success kontrola          ${user_mail_3}      ${user_pass_3}          ${TEXT_not_logged_in}
    Error mssge

Login - blank mail
    Login success kontrola          ${EMPTY}            ${user_pass_4}          ${TEXT_not_logged_in}
    Blank mail error

Login - blank pass
    Login success kontrola          ${user_mail_5}      ${EMPTY}                ${TEXT_not_logged_in}
    Blank pass error

Login - blank all
    Login success kontrola          ${EMPTY}            ${EMPTY}                ${TEXT_not_logged_in}
    Blank all errors

Logout - success
    Logout                          ${user_mail_1}      ${user_pass_1}          ${TEXT_logged_out}

Logout - fail
    Logout                          ${user_mail_1}      ${user_pass_1}          ${TEXT_not_logged_out}

*** Keywords ***
Error mssge
    Get Text                    ${SEL_error_login_incorrect_mail}   ==          ${ErrorText_login_incorrect_mail}
    Log                         "These credentials do not match our records." message is displayed
    Take Screenshot

Blank mail error
    Get Text                    ${SEL_error_login_blank_mail}       ==          ${ErrorText_login_blank_mail}
    Log                         Polozka email je povinna!
    Take Screenshot

Blank pass error
    Get Text                    ${SEL_error_login_blank_pass}       ==          ${ErrorText_login_blank_pass}
    Log                         Polozka heslo je povinne!
    Take Screenshot

Blank all errors
    Get Text                    ${SEL_error_login_blank_mail}        ==         ${ErrorText_login_blank_mail}
    Get Text                    ${SEL_error_login_blank_pass}        ==         ${ErrorText_login_blank_pass}
    Log                         Polozka email a heslo jsou povinna!
    Take Screenshot

Login success kontrola
    [Arguments]                 ${email}        ${password}         ${logged}
    Login success nokontrola    ${email}        ${password}

    IF    "${logged}" == "${TEXT_logged_in}"
         Get Text     ${SEL_button_logout}            ==      ${TEXT_to_log_out}
    ELSE
         Get Text     ${SEL_button_login_link}        ==      ${TEXT_to_log_in}
    END

    Take Screenshot

Login success nokontrola
    [Arguments]     ${email}     ${password}

    New Browser    ${Browser}    headless=False
    New Page       ${URL}

    Click          ${SEL_button_login_link}
    Get Url        *=  login
    Log            URL contains "kitner.cz/login"
    Type Text      ${SEL_login_form_email}                          ${email}
    Log            ${email} zadan
    Type Text      ${SEL_login_form_pass}                           ${password}
    Log            ${password} zadan
    Click          ${SEL_login_form_login_button}
    Log            Login macknut

Logout
    [Arguments]                 ${email}        ${password}         ${logged}

    Login success nokontrola    ${email}        ${password}

    IF    "${logged}" == "${TEXT_logged_out}"
        Click           ${SEL_button_logout}
        Get Text        ${SEL_button_login_link}        ==      ${TEXT_to_log_in}
    ELSE
         Get Text       ${SEL_button_logout}            ==      ${TEXT_to_log_out}
    END

    Take Screenshot

Pred_sadou
   New Browser              chromium   headless=False
   Sleep                    ${SleepBeforeTest}

Pred_testem
#   New Browser              chromium   headless=False
   New Page                 ${URL}
   Set Browser Timeout      ${TimeOut_Browser}
   Sleep                    ${SleepBeforeTest}

Uklid_sada
    Get Url        *=  ${URL}
    Log            URL contains "kitner.cz"
    Close Browser