*** Settings ***
Library     Browser

Resource    DU_05_TestData.robot
Resource    DU_05_Keywords.robot
Resource    DU_05_Configuration.robot

Suite Setup     Pred sadou
#Suite Teardown  Po sade

Test Setup      Pred testom
#Test Teardown   Po teste

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}

*** Test Cases ***

Login - prihlaseny
    Login                               ${EMAIL}        ${PASSWORD}         PRIHLASENY
#    Uzivatel prihlaseny kontrola
    [Teardown]  Logout

Login - neprihlaseny - zly email
    Login                               ${BAD_EMAIL}    ${PASSWORD}         PRIHLÁSIŤ SA
#    Uzivatel neprihlaseny kontrola

Login - neprihlaseny - zle heslo
    Login                               ${EMAIL}        ${BAD_PASSWORD}     PRIHLÁSIŤ SA
#    Uzivatel neprihlaseny kontrola

Login - prazdny email
    Login                               ${EMPTY}        ${PASSWORD}         PRIHLÁSIŤ SA
#    Uzivatel neprihlaseny kontrola
    Chybova hlaska - prazdny email

Login - prazdne heslo
    Login                               ${EMAIL}        ${EMPTY}            PRIHLÁSIŤ SA
#    Uzivatel neprihlaseny kontrola
    Chybova hlaska - prazdne heslo


*** Keywords ***

Pred sadou
    ${b_timeput} =          Set Browser Timeout         ${TIMEOUT_BROWSER}
    New Browser             headless=False

Pred testom
    New Page        ${URL}
    Get Title       contains                ${TITLE}
Po teste
    Logout

Po teste
    Logout

Po sade
    Close Browser
