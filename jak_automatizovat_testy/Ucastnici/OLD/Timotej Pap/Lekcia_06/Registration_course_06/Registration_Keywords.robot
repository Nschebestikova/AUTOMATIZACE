*** Settings ***
Library     Browser


Resource    Registration_Configuration.robot
Resource    Registration_TestData.robot


*** Keywords ***
Login
    [Arguments]         ${CORRECT_USER_EMAIL}       ${CORRECT_USER_PASSWORD}       ${TEXT}
    Click               ${SEL_LOGIN}
    Type Text           ${SEL_EMAIL_INPUT}          ${CORRECT_USER_EMAIL}
    Type Text           ${SEL_PASSWORD_INPUT}       ${CORRECT_USER_PASSWORD}
    Click               ${SEL_SUBMIT}

    IF    "${TEXT}" == "PRIHLASENY"
       Get Text          ${SEL_LOGOUT}
       Log To Console    ${TEXT_LOGGED_IN}
    ELSE
       Log To Console    ${TEXT_NOT_LOGGED_IN}
    END

Logout
    Click               ${SEL_LOGOUT}
    Log                 ${TEXT_NOT_LOGGED_IN}

Error text - empty email
    Get Text            ${TEXT_EMPTY_EMAIL}

Error text - empty password
    Get Text            ${TEXT_EMPTY_PASSWORD}

Registration OK
    Set Strict Mode     off
    Click               ${SEL_COURSE_LINK}
    Click               ${SEL_REGISTRATION_LINK}
    Get Text            ${TEXT_REGISTRATION_TITLE}
    Type Text           ${SEL_IC_LINK}                          ${TEXT_ICO}
    Type Text           ${SEL_TELEFON_LINK}                     ${TEXT_TELEFON}
    Click               ${SEL_SUBMIT_REGISTRATION_LINK}

Registration check
    Set Strict Mode     off
    [Arguments]         ${CORRECT_USER_EMAIL}              ${CORRECT_USER_PASSWORD}       ${TEXT}
    Click               ${SEL_LOGIN}
    Type Text           ${SEL_EMAIL_INPUT}          ${ADMIN_EMAIL}
    Type Text           ${SEL_PASSWORD_INPUT}       ${ADMIN_PASSWORD}
    Click               ${SEL_SUBMIT}

    IF    "${TEXT}" == "PRIHLASENY"
       Get Text          ${SEL_LOGOUT}
       Log To Console    ${TEXT_LOGGED_IN}
    ELSE
       Log To Console    ${TEXT_NOT_LOGGED_IN}
    END

    Click               ${COURSE_NAME}
    Click               ${SEL_REGISTRATION_LINK}
    Get Text            ${TEXT_REGISTRATION_TITLE}
    Click               ${SEL_USER_LOGGED_LINK}
#    Get Text            ${NAME_USER}
#    Log                 ${NAME_USER}

Registration NO OK
    Set Strict Mode     off
    Click               ${SEL_COURSE_LINK}
    Click               ${SEL_REGISTRATION_LINK}
    Get Text            ${TEXT_REGISTRATION_TITLE}
    Type Text           ${SEL_IC_LINK}              ${EMPTY}
    Type Text           ${SEL_TELEFON_LINK}         ${EMPTY}
    Click               ${SEL_SUBMIT_REGISTRATION_LINK}
    Get Text            "Neplatné IČO"
    Get Text            "Telefonní číslo musí obsahovat alespoň 9 číslic."