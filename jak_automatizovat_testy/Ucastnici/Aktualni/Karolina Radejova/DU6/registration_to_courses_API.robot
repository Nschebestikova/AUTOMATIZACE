*** Settings ***
Library     RequestsLibrary
Library     String
Library     Browser
Library     FakerLibrary
Library    Collections

Resource   ../Project/Data_and_Config/TestData_API.robot
Resource   ../Project/Data_and_Config/Configuration_API.robot

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}
${URLlistreg}   http://testovani.kitner.cz/regkurz/list.php

*** Test Cases ***
#chybi:
# vyresit KS Check the table contains registered user with correct data

#positive TCs
Registration OK - fyzicka osoba, filled address and ico, phone +420 , filled comment, souhlas - true
    API Communication    ${JSON_correct_values_1}                           200
    #Check the table contains registered user with correct data          ${course_name_1}    ${name_1}    ${surname_1}    ${email_1}    ${phone_1}    ${person_1}    ${address_1}    ${ico_1}    ${count_1}    ${comment_1}    ${souhlas_string}
    Sleep    8s
    API GET - check the table contains registered user with correct data    ${email_1}

Registrace OK - pravnicka osoba, filled ico, filled count, empty address, empty comment, empty souhlas
    API Communication    ${JSON_correct_values_2}                       200

Registrace OK - fyzicka osoba, phone +420, filled address, filled count, empty ico, empty comment, empty souhlas
    API Communication    ${JSON_correct_values_3}                       200

#negative TCs
Registration NOK - all empty values
    API Communication    ${JSON_empty_all_values}                       500

Registration NOK - empty mandatory values
    API Communication    ${JSON_empty_mandatory_values}                 500

Registration NOK - null values
    API Communication    ${JSON_null_all_values}                        500

Registration NOK - empty address, user is fyzicka osoba
    API Communication    ${JSON_empty_address_fyz_os}                   500
    
Registration NOK - empty ICO, user is pravnicka osoba
    API Communication    ${JSON_empty_ico_pra_os}                       500

Registration NOK - empty course number
    API Communication    ${JSON_empty_course_number}                    500

#test failes if variable = 4, passed if variable = "4"
Registration NOK - incorrect course number (integer)
    API Communication    ${JSON_incorrect_course_number_int}            500

Registration NOK - incorrect course number (string)
    API Communication    ${JSON_incorect_course_number_string}          500

Registration NOK - incorrect email format
    API Communication    ${JSON_incorrect_mail}                         500

Registration NOK - phone with prefix too short
    API Communication    ${JSON_incorrect_phone_short_420}              500

Registration NOK - phone without prefix too short
    API Communication    ${JSON_incorrect_phone_short_without_420}      500

Registration NOK - phone with prefix is too long
    API Communication    ${JSON_incorrect_phone_long_420}               500

Registration NOK - phone without prefix is too long
    API Communication    ${JSON_incorrect_phone_long_without_420}       500

Registration NOK - incorrect phone format
    API Communication    ${JSON_incorrect_phone_format}                 500

#user is registered with incorrect person value - projde jiná hodnota než fyz/pra
Registration NOK - incorrect person type
    API Communication    ${JSON_incorrect_typ_os}                       500

#address field has not validation for length, is it for purpose?
Registration OK - long address
    API Communication    ${JSON_address_long}                           200

Registration OK - wrong ICO, fyzicka osoba
    API Communication    ${JSON_incorrect_ico_fyz}                      200

Registration NOK - wrong ICO, pravnicka osoba
    API Communication    ${JSON_incorrect_ico}                          500

Registration NOK - incorrect count format
    API Communication    ${JSON_incorrect_count}                        500

#hodnoty string, null, float -> registrace se provede a souhlas je nastaveny na hodnotu false, tj. NE
Registration NOK - souhlas in wrong format (string)
    API Communication    ${JSON_souhlas_wrong_format}                   500

Registration NOK - incorrect json format (missing value - person)
    API Communication    ${JSON_incorrect_json_format_missing_value}    500

Registration NOK - incorrect json format (missing character)
    API Communication    ${JSON_incorrect_format_missing_character}     500

*** Keywords ***

API Communication
    [Arguments]     ${json}     ${error_response}

    ${json_utf8} =      Encode String To Bytes    ${json}    UTF-8

    ${resp} =           POST    ${urlapp}   data=${json_utf8}   expected_status=anything

    Log                 ${resp.json()}
    Log                 ${resp.json()}[response]

    IF    "${resp.json()}[response]" != "200"
        Log                 ${resp.json()}[reason]
        Log                 ${resp.json()}[problem]

    END

    Status Should Be    ${error_response}

#not effective way to check it - there is a lot of logs of registrations and the test execution takes a long time
Check the table contains registered user with correct data
    [Arguments]     ${course}       ${name}     ${surname}      ${email}        ${phone}        ${typ_os}       ${address}      ${ico}      ${count}        ${comment}      ${souhlas}
    New Page                 ${URLlistreg}
    Set Browser Timeout      ${TimeOut_Browser}
    Sleep                    ${SLEEP_BEFORE_TEST}
    Get Title    ==          list registraci
    Log                      List with registrations was open

    ${count_logs} =      Get Element Count    td:nth-child(1)
    Log    ${count}

    ${email_found} =    Set Variable    False
    FOR    ${counter}    IN RANGE    1  ${count_logs}
        Log    ${counter}
        ${table_course} =   Get Text    td:nth-child(1) >> nth=${counter}
        ${table_name} =     Get Text    td:nth-child(2) >> nth=${counter}
        ${table_surname} =  Get Text    td:nth-child(3) >> nth=${counter}
        ${table_email} =    Get Text    td:nth-child(4) >> nth=${counter}
        ${table_phone} =    Get Text    td:nth-child(5) >> nth=${counter}
        ${table_typ_os} =   Get Text    td:nth-child(6) >> nth=${counter}
        ${table_address} =  Get Text    td:nth-child(7) >> nth=${counter}
        ${table_ico} =      Get Text    td:nth-child(8) >> nth=${counter}
        ${table_count} =    Get Text    td:nth-child(9) >> nth=${counter}
        ${table_comment} =  Get Text    td:nth-child(10) >> nth=${counter}
        ${table_souhlas} =  Get Text    td:nth-child(11) >> nth=${counter}

        IF    "${table_course}" == "${course}" and "${table_name}" == "${name}" and "${table_surname}" == "${surname}" and "${table_email}" == "${email}" and "${table_phone}" == "${phone}" and "${table_typ_os}" == "${typ_os}" and "${table_address}" == "${address}" and "${table_ico}" == "${ico}" and "${table_count}" == "${count}" and "${table_comment}" == "${comment}" and "${table_souhlas}" == "${souhlas}"
            ${email_found} =    Set Variable    True
            BREAK
        END
    END

    Log    Result: ${email_found}

#effective way - via GET and check the response body contains correct values
API GET - check the table contains registered user with correct data
    [Arguments]     ${email}
    ${response_get} =   Get     ${URLlistreg}   expected_status=anything

    #log the content of GET response
    Log    ${response_get.content}

    #convert response content to string type
    ${response_string} =    Convert To String    ${response_get.content}

    #verification that data are in GET response
    Should Contain    ${response_string}    ${email}

    Log               Response contains correct email from registration.
