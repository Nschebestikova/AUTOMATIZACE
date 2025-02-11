*** Settings ***
Library         Browser

Resource        Registration_Configuration.robot
Resource        Registration_Keywords.robot
Resource        Registration_TestData.robot

Suite Setup     Pred sadou
##Suite Teardown  Po sade

Test Setup      Pred testom
#Test Teardown   Po teste

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}

*** Test Cases ***
Login correct
    Login               ${CORRECT_USER_EMAIL}   ${CORRECT_USER_PASSWORD}    PRIHLASENY
    [Teardown]          Logout

Login incorrect - bad email
    Login               ${BAD_USER_EMAIL}       ${CORRECT_USER_PASSWORD}    ${TEXT_NOT_LOGGED_IN}

Login incorrect - bad password
    Login               ${CORRECT_USER_EMAIL}   ${BAD_USER_PASSWORD}        ${TEXT_NOT_LOGGED_IN}

Login incorrect - empty email
    Login               ${EMPTY}                ${BAD_USER_PASSWORD}        ${TEXT_NOT_LOGGED_IN}
    Error text - empty email

Login incorrect - empty password
    Login               ${CORRECT_USER_EMAIL}   ${EMPTY}                    ${TEXT_NOT_LOGGED_IN}
    Error text - empty password


Registration correct
    Login               ${CORRECT_USER_EMAIL}   ${CORRECT_USER_PASSWORD}    PRIHLASENY
    Registration OK
    [Teardown]          Logout

Registration checking
    Registration check  ${ADMIN_EMAIL}          ${ADMIN_PASSWORD}           PRIHLASENY


Registration incorrect
    Login               ${CORRECT_USER_EMAIL}   ${CORRECT_USER_PASSWORD}    PRIHLASENY
    Registration NO OK


*** Keywords ***
Pred sadou
    ${b_timeput} =          Set Browser Timeout     ${TIMEOUT_BROWSER}
    New Browser             headless=False

Pred testom
    New Page                ${URL}
    Get Title               contains                ${TEXT_TITLE}
#
#Po teste
#
#
#Po sade
