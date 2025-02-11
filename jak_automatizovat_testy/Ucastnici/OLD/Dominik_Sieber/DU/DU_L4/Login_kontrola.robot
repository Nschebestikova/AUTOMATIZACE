*** Settings ***
Library     Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Test Cases ***
Login - success
    Login success kontrola       giyipem264@v1zw.com     tajnenovak          Prihlasen

Login - wrong password
    Login success kontrola       giyipem264@v1zw.com     hoja                Neprihlasen
    Error mssge

Login - wrong mail
    Login success kontrola       d@sieber.com           tajnenovak          Neprihlasen
    Error mssge

Login - blank mail
    Login success kontrola       ${EMPTY}                tajnenovak          Neprihlasen
    Blank mail error

Login - blank pass
    Login success kontrola       dominik@sieber.com      ${EMPTY}            Neprihlasen
    Blank pass error

Login - blank all
    Login success kontrola       ${EMPTY}                ${EMPTY}            Neprihlasen
    Blank all errors

Logout - success
    Logout               giyipem264@v1zw.com     tajnenovak          Odhlasen

Logout - fail
    Logout               giyipem264@v1zw.com     tajnenovak          Neodhlasen

*** Keywords ***
Error mssge
    Get Text                    data-test=email_input_errors        ==      These credentials do not match our records.
    Log                         "These credentials do not match our records." message is displayed
    Take Screenshot

Blank mail error
    Get Text                    data-test=email_input_errors      ==      The email field is required.
    Log                         Polozka email je povinne
    Take Screenshot

Blank pass error
    Get Text                    data-test=password_input_errors      ==      The password field is required.
    Log                         Polozka heslo je povinne
    Take Screenshot

Blank all errors
    Get Text                    data-test=email_input_errors         ==      The email field is required.
    Get Text                    data-test=password_input_errors      ==      The password field is required.
    Log                         Polozka email a heslo jsou povinna
    Take Screenshot

Login success kontrola
    [Arguments]                 ${email}    ${password}     ${logged_in}
    Login success nokontrola    ${email}    ${password}

    IF    "${logged_in}" == "Prihlasen"
        Get Text    data-test=logout_button     ==      Odhlásit se
    ELSE
         Get Text    data-test=login_link       ==      Přihlásit se
    END

    Take Screenshot

Login success nokontrola
    [Arguments]             ${email}     ${password}

    New Browser     chromium    headless=false
    New Page        ${URL}

    Click           data-test=login_link
    Get Url         *=  login
    Log             Url contains "kitner.cz/login"
    Type Text       data-test=email_input    ${email}
    Log             ${email} zadan
    Type Text       data-test=password_input    ${password}
    Log             ${password} zadan
    Click           data-test=login_button
    Log             Login macknut

Logout
    [Arguments]     ${email}        ${password}     ${logged_in}

    Login success nokontrola    ${email}    ${password}

    IF    "${logged_in}" == "Odhlasen"
        Click       data-test=logout_button
        Get Text    data-test=login_link        ==      Přihlásit se
    ELSE
         Get Text    data-test=logout_button    ==      Odhlásit se
    END

    Take Screenshot
