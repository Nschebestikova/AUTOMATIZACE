*** Settings ***
Library     RequestsLibrary
Library     String
Library     Browser

Resource    ../DU7/TestDataLoginRegistration.robot

*** Variables ***
${url}		        http://testovani.kitner.cz
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}

*** Test Cases ***
Login OK
    POST login    ${user}                   ${password}                     ${useragent}            200

Login NOK - empty all values
    POST login    ${empty_user}             ${empty_password}               ${empty_useragent}      403

Login NOK - empty username
    POST login    ${empty_user}             ${password}                     ${useragent}            403

Login NOK - empty password
    POST login    ${user}                   ${empty_password}               ${useragent}            403

Login NOK - empty useragent
    POST login    ${user}                   ${password}                     ${empty_useragent}      403

Login NOK - all values null
    POST login    ${null_user}              ${null_password}                ${null_useragent}       403

Login NOK - wrong username
    POST login    ${wrong_user}             ${password}                     ${useragent}            403

Login NOK - wrong password
    POST login    ${user}                   ${wrong_password}               ${useragent}            403

Login NOK - wrong username and password
    POST login    ${wrong_user}             ${wrong_password}               ${useragent}            403

Login NOK - wrong username, special characters
    POST login    ${special_char_user}      ${password}                     ${useragent}            403

Login NOK - wrong password, special characters
    POST login    ${user}                   ${special_char_password}        ${useragent}            403

Login NOK - wrong username, diacritic
    POST login    ${user_diacritic}         ${password}                     ${useragent}            403

Login NOK - wrong password, diacritic
    POST login    ${user}                   ${password_diacritic}           ${useragent}            403

Login NOK - long wrong username, len(username) = 20
    POST login    ${user_20}                ${password}                     ${useragent}            403

#test fails if len(username) > 20
Login NOK - long wrong username, len(username) = 21
    POST login    ${long_user}              ${password}                     ${useragent}            403

Login NOK - long wrong password
    POST login    ${user}                   ${long_password}                ${useragent}            403

Login NOK - wrong json format, missing value
    API Communication                       ${wrong_json_missing_value}                             403

Login NOK - wrong json format, missing quatation mark
    API Communication                       ${wrong_json_missing_char}                              403

Login NOK - wrong json format, added special character # in json
    API Communication                       ${wrong_json_added_char}                                403

*** Keywords ***

POST login
    [Arguments]     ${username}     ${password}     ${useragent}        ${response_code}

    ${json} =           Set Variable   {"username":"${username}","password":"${password}","useragent":"${useragent}"}

    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    ${header} =         Create Dictionary   Content-Type=application/json

    ${resp} =           POST    ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=anything

    IF    "${resp.json()}[response]" != "200"
        Log                 ${resp.json()}[response]
        Log                 ${resp.json()}[reason]

    END

    Should Contain      ${resp.json()}[response]        ${response_code}
    Log                 ${resp.json()}[response] is same as ${response_code}
    
    
API Communication
    [Arguments]     ${json}     ${error_response}

    ${json_utf8} =      Encode String To Bytes    ${json}    UTF-8

    ${resp} =           POST    ${urlapp}   data=${json_utf8}   expected_status=anything

    Log                 ${resp.json()}
    Log                 ${resp.json()}[response]

    IF    "${resp.json()}[response]" != "200"
        Log                 ${resp.json()}[response]
        Log                 ${resp.json()}[reason]

    END

    Should Contain      ${resp.json()}[response]        ${error_response}
    Log                 ${resp.json()}[response] is same as ${error_response}