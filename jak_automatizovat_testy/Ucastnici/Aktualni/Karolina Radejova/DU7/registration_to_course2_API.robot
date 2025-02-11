*** Settings ***
Library     RequestsLibrary
Library     String

Resource    ../DU7/TestDataLoginRegistration.robot

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

*** Test Cases ***
Registration OK - fyz, phone +420
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_fyz}       ${address}                          ${count}            ${comment}    ${souhlas_true}                   200

Registration OK - fyz, phone 777
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_fyz}       ${address}                          ${count}            ${comment}    ${souhlas_false}                  200

Registration OK - pra, phone +420
    Registration to course    3                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_true}     200

Registration OK - pra, phone 777
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_false}    200

Registration OK - fyz, diacritics
    Registration to course    2                         ${name_diacritics}      ${surname_diacritics}       ${email}            ${phone_777}            ${person_fyz}       ${address_diacritics}               ${count}            ${comment_diacritics}       ${souhlas_false}    200

Registration OK - pra, diacritics
    Registration to course    2                         ${name_diacritics}      ${surname_diacritics}       ${email}            ${phone_777}            ${person_pra}       ${ico}                              ${count}            ${comment_diacritics}       ${souhlas_false}    200

Registration OK - fyz, long address
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_fyz}       ${address_too_long}                 ${count}            ${comment}                  ${souhlas_false}    200

Registration OK - fyz, long comment format
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_fyz}       ${address}                          ${count}            ${comment_long}             ${souhlas_true}     200

Registration OK - pra, long comment format
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_pra}       ${ico}                              ${count}            ${comment_long}             ${souhlas_false}    200

#it depends on demands, if the strings have allowed special symbols or not
Registration NOK - fyz, special symbols
    Registration to course    1                         ${name_specials}        ${surname_specials}         ${email}            ${phone_420}            ${person_fyz}       ${address_specials}                 ${count}            ${comment_specials}         ${souhlas_true}     500

#it depends on demands, if the strings have allowed special symbols or not
Registration NOK - pra, special symbols
    Registration to course    1                         ${name_specials}        ${surname_specials}         ${email}            ${phone_420}            ${person_pra}       ${ico}                              ${count}            ${comment_specials}         ${souhlas_true}     500

Registration NOK - fyz, all empty values
    Registration to course    3                         ${name_empty}           ${surname_empty}            ${email_empty}      ${phone_empty}          ${person_empty}     ${address_empty}                    ${count_empty}      ${comment_empty}            ${souhlas_empty}    400

Registration NOK - pra, all empty values
    Registration to course    3                         ${name_empty}           ${surname_empty}            ${email_empty}      ${phone_empty}          ${person_empty}     ${ico_empty}                        ${count_empty}      ${comment_empty}            ${souhlas_empty}    400

Registration NOK - fyz, all null values
    Registration to course    2                         ${name_null}            ${surname_null}             ${email_null}       ${phone_null}           ${person_null}      ${address_null}                     ${count_null}       ${comment_null}             ${souhlas_null}     500

Registration NOK - pra, all null values
    Registration to course    2                         ${name_null}            ${surname_null}             ${email_null}       ${phone_null}           ${person_null}      ${address_null}                     ${count_null}       ${comment_null}             ${souhlas_null}     500

Registration NOK - fyz, empty address
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_fyz}       ${address_empty}                    ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - pra, empty ico
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_pra}       ${ico_empty}                        ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - pra, wrong ico (incorrect ico)
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_pra}       ${ico_wrong_incorrect_number}       ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - pra, wrong ico (long number)
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_pra}       ${ico_wrong_long_number}            ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - pra, wrong ico (string)
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_pra}       ${ico_wrong_string}                 ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - fyz, empty course number
    Registration to course    ${course_empty}           ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_false}    500

Registration NOK - pra, empty course number
    Registration to course    ${course_empty}           ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - fyz, wrong course number
    Registration to course    ${course_wrong_number}    ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_false}    500

Registration NOK - pra, wrong course number
    Registration to course    ${course_wrong_number}    ${name}                 ${surname}                  ${email}            ${phone_420}            ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - fyz, wrong email
    Registration to course    1                         ${name}                 ${surname}                  ${email_wrong}      ${phone_420}            ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - pra, wrong email
    Registration to course    3                         ${name}                 ${surname}                  ${email_wrong}      ${phone_420}            ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - fyz, phone too short +420
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420_short}      ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - pra, phone too short +420
    Registration to course    3                         ${name}                 ${surname}                  ${email}            ${phone_420_short}      ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - fyz, phone too short 777
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777_short}      ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_false}    500

Registration NOK - pra, phone too short 777
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777_short}      ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_false}    500

Registration NOK - fyz, wrong format phone +420
    Registration to course    1                         ${name}                 ${surname}                  ${email}            ${phone_420_wrong}      ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - pra, wrong format phone +420
    Registration to course    3                         ${name}                 ${surname}                  ${email}            ${phone_420_wrong}      ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_true}     500

Registration NOK - fyz, wrong format phone 777
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777_wrong}      ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_false}    500

Registration NOK - pra, wrong format phone 777
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777_wrong}      ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_false}    500

Registration NOK - fyz, wrong format of souhlas
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_fyz}       ${address}                          ${count}            ${comment}                  ${souhlas_wrong}    400

Registration NOK - pra, wrong format of souhlas
    Registration to course    2                         ${name}                 ${surname}                  ${email}            ${phone_777}            ${person_pra}       ${ico}                              ${count}            ${comment}                  ${souhlas_wrong}    400

Registration NOK - fyz, wrong json format (missing quatation mark)
    Registration to course - json format                ${fyz_missing_quat_mark}                            500

Registration NOK - pra, wrong json format (missing quatation mark)
    Registration to course - json format                ${pra_missing_quat_mark}                            500

Registration NOK - fyz, wrong json format (missing key-value)
    Registration to course - json format                ${fyz_missing_key_val_course}                       500

Registration NOK - pra, wrong json format (missing key-value)
    Registration to course - json format                ${pra_missing_key_val_course}                       500

*** Keywords ***
Registration to course
    [Arguments]     ${course}       ${name}     ${surname}      ${email}    ${phone}    ${person}   ${address_ico}  ${count}    ${comment}      ${souhlas}      ${response_code}

    IF      "${person}" == "pra"
            ${json} =    Set Variable      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    ELSE
            ${json} =   Set Variable        {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    END

    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8
    ${header} =     Create Dictionary   Content-Type=application/json
    ${resp} =   POST    ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=anything

    Status Should Be    ${response_code}

Registration to course - json format
    [Arguments]     ${json}     ${error_response}

    ${json_utf8} =      Encode String To Bytes    ${json}    UTF-8

    ${resp} =           POST    ${urlapp}   data=${json_utf8}   expected_status=anything

    Log                 ${resp.json()}                  TRACE
    Log                 ${resp.json()}[response]        DEBUG

    IF    "${resp.json()}[response]" != "200"
        Log                 ${resp.json()}[reason]
        Log                 ${resp.json()}[problem]

    END

    Status Should Be    ${error_response}


