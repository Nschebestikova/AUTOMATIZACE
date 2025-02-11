*** Settings ***
Library     RequestsLibrary
Library     String
Library     Browser

Resource    ../Data_and_Config/TestData.robot

*** Test Cases ***
TestLogin_Success
    POST TestLogin  ${user}         ${password}         ${useragent}        200

TestLogin_EmptyUsername
    POST TestLogin  ${user_empty}   ${password}         ${useragent}        403

TestLogin_EmptyPassword
    POST TestLogin  ${user}         ${password_empty}   ${useragent}        403

TestLogin_EmptyUserAgent
    POST TestLogin  ${user}         ${password}         ${useragent_empty}  403

TestLogin_EmptyAllFields
    POST TestLogin  ${user_empty}   ${password_empty}   ${useragent_empty}  403

TestLogin_IncorrectUsername
    POST TestLogin  ${USER1_NAME}   ${password}         ${useragent}        403

TestLogin_IncorrectPassword
    POST TestLogin  ${user}         ${USER1_PASSWORD}   ${useragent}        403

TestLogin_UsernameSpecialCharacter
    POST TestLogin  ${special_char}     ${password}     ${useragent}        403

TestLogin_PasswordSpecialCharacter
    POST TestLogin  ${user}         ${special_char}     ${useragent}        403

TestLogin_UsernameTooLong
    POST TestLogin  ${user_too_long}    ${password}     ${useragent}        403

TestLogin_PasswordTooLong
    POST TestLogin  ${user}         ${password_too_long}    ${useragent}        403

TestLogin_API_OK
    API Communication    ${JSON_login}      200

TestLogin_API_IncorrectJSONFormat_MissingQuationMark
    API Communication    ${missingQuotationIncorrectJSON_login}     403

TestLogin_API_EmptyUserValueJSON
    API Communication    ${emptyUserValueJSON_login}                403


*** Keywords ***
POST TestLogin
    [Arguments]     ${username}     ${password}     ${useragent}        ${response_code}

    ${json}=            Set Variable    {"username":"${username}","password":"${password}","useragent":"${useragent}"}

    ${json_utf8}=       Encode String To Bytes      ${json}     UTF-8

    ${header}=          Create Dictionary   Content-Type=application/json

    ${resp} =           POST    ${urlapp_login}   data=${json_utf8}   headers=${header}   expected_status=anything

    IF    "${resp.json()}[response]" != "200"
        Log                 ${resp.json()}[response]
        Log                 ${resp.json()}[reason]

    END

    Should Contain      ${resp.json()}[response]        ${response_code}
    Log                 ${resp.json()}[response] is same as ${response_code}


API Communication
    [Arguments]     ${json}     ${error_response}

    ${json_utf8}=   Encode String To Bytes      ${json}     UTF-8

    ${resp}=        POST        ${urlapp_login}       data=${json_utf8}       expected_status=anything

    Log             ${resp.json()}
    Log             ${resp.json()}[response]

    IF              "${resp.json()}[response]" != "200"
        Log         ${resp.json()}[response]
        Log         ${resp.json()}[reason]

    END

    Should Contain      ${resp.json()}[response]            ${error_response}
    Log                 ${resp.json()}[response] is same as ${error_response}
