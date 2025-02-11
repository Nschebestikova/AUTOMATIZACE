*** Settings ***
Library         Browser
Library         RequestsLibrary
Library         String

Resource        ../Data_and_Config/TestData.robot
Resource        ../Data_and_Config/Configuration.robot


*** Test Cases ***
GET request
        ${response}=    GET     ${url}

Registration - Success
        API Communication       ${correctJSON}              200

Registration - Name Too Long
        API Communication       ${nameTooLongJSON}          400

Registration - Empty Course Value
        API Communication       ${emptyCourseValueJSON}     400

Registration - Empty Course Key
        API Communication       ${emptyCourseKeyJSON}       400

Registration - Incorrect JSON Format
        API Communication       ${missingQuotationIncorrectJSON}    400

Registration - Incorrect Special Character in Course Value
        API Communication       ${specialCharacterCourseValueJSON}  400

Registration - Incorrect Special Character in ICO
        API Communication       ${specialCharacterIcoJSON}          400


*** Keywords ***
API Communication
        [Arguments]         ${json}       ${error_resp}

        ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

        ${resp} =           POST  ${urlapp}   data=${json_utf8}    expected_status=${error_resp}

        Log To Console      ${resp.json()}[response]
        Should Be Equal     ${resp.json()}[response]    ${error_resp}