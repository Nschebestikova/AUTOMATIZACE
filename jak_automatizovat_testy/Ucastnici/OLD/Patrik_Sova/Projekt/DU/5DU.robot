

*** Settings ***
Metadata    Author    Patrik Sova
Metadata    Purpose   Test login with check + TestData+Configuration
Metadata    Created   16.1.2024

Library  Browser
Resource    ../Data_and_Config/Configuration.robot
Resource    ../Data_and_Config/TestData.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}

*** Test Cases ***

Wrong Login
    Login               ${USER1_NAME_Wrong_1}       ${USER1_Password_Correct_1}       no
    User wrong login
Wrong Password
    Login              ${USER1_NAME_Correct_1}      ${USER1_Password_Wrong_1}          no
    User wrong password
Login Success
    Login              ${USER1_NAME_Correct_1}      ${USER1_Password_Correct_1}      yes
    User is logged in
    User has logged out

*** Keywords ***

Login
    [Arguments]     ${login}      ${password}       ${text}

    log             ${login}
    log             ${password}


    New Browser           CHROMIUM          headless=false
    New Page              ${URL}
    Get Title            *=                         ${TEXT_MainTitle}
    Type Text            ${SEL_username_id}         ${login}
    Type Text            ${SEL_password_id}         ${password}
    Sleep                ${TIME_BETWEEN_CLICKS}
    Click                ${SEL_submit_id}
    Sleep                ${TIME_BETWEEN_CHECKS}
    Take Screenshot


    IF    "${text}" == "yes"
       Get Text     ${SEL_post_title_css}      ==            ${TEXT_Success_Login}
       Log To Console    ${TEXT_To_Console_1}
    ELSE
       Get Text     ${SEL_submit_css}             ==         ${TEXT_other}
       Log To Console    ${TEXT_To_Console_1}
    END

User is logged in
       Sleep                ${TIME_BETWEEN_CHECKS}
       Get Text        ${SEL_post_title_css}         ==       ${TEXT_Success_Login}   # AssertPoz1

       Take Screenshot

User has logged out
        Sleep                ${TIME_BETWEEN_CLICKS}
        Click        ${SEL_logout_button_css}

        Take Screenshot

User wrong login
        Sleep                ${TIME_BETWEEN_CHECKS}
        Get Text   ${SEL_error_xpath}                  ==        ${TEXT_Invalid_Username}      # AssertNeg1
        Take Screenshot

User wrong password
        Sleep                ${TIME_BETWEEN_CHECKS}
        Get Text   ${SEL_error_xpath}                   ==        ${TEXT_Invalid_Password}      # AssertNeg1
        Take Screenshot


Pred_sadou
    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      ${TEXT_MainTitle}

Uklid_sada
    Close Browser

#Test Setup & Teardown
Pred_testem
    Go To           ${URL}

Uklid_po_testu
    Go To           ${URL}