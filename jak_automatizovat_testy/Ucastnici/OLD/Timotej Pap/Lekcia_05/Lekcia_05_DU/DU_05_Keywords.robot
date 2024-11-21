*** Settings ***
Library     Browser

Resource    DU_05_TestData.robot
Resource    DU_05_Configuration.robot

*** Keywords ***

Login
    [Arguments]             ${EMAIL}                ${PASSWORD}            ${TEXT}
    Click                   ${SEL_COOKIE}
    Get Element States      ${SEL_ELEMENT_STATE}
    Click                   ${SEL_LOGIN_LINK}
    Type Text               ${SEL_LOGIN_EMAIL}      ${EMAIL}
    Type Text               ${SEL_LOGIN_PSW}        ${PASSWORD}
    Click                   ${SEL_SUBMIT}

#    ${menu} =   Get Text    ${SEL_MENU}
#    Log To Console    ${menu}
#    IF  "ODHLÁSIŤ SA" in "${menu}"
#        Log    uzivatel sa musi odhlasit
#        Logout
#    ELSE
#        Log    uzivatel je odhlaseny
#    END


    IF    "${TEXT}" == "PRIHLASENY"
       Get Text     ${SEL_LOGOUT_LINK}         ==            ODHLÁSIŤ SA
   ELSE
       Get Text     ${SEL_LOGIN_LINK}          ==            ${text}
   END

Logout
    Click                   ${SEL_LOGOUT_LINK}

Uzivatel prihlaseny kontrola
    Get Text                ${SEL_LOGOUT_LINK}
    Take Screenshot

Uzivatel neprihlaseny kontrola
    Get Text                ${SEL_LOGIN_LINK}
    Take Screenshot

Chybova hlaska - prazdny email
    Get Text                ${ERROR_EMAIL_TEXT}
    Take Screenshot

Chybova hlaska - prazdne heslo
    Get Text                ${ERROR_PASSWORD_TEXT}
    Take Screenshot