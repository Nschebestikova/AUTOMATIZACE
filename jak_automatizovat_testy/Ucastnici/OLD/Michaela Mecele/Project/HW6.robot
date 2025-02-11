*** Settings ***
Library               RequestsLibrary
Resource   TestData/ProjectData.robot

*** Test Cases ***
SimpleGetRequestTest
        ${response}=    GET   ${url}

RegOK
        Communication     ${jsonOK}      200

RegOKTel+420
        Communication     ${jsonOK+420}      200

RegOKPravnickaOsoba
        Communication     ${jsonOKPerPrav}      200

RegWithoutPerson
        Communication     ${jsonEmptyPer}      400

RegWithoutComent
        Communication     ${jsonEmptyComent}      200

RegWithoutCourse
        Communication     ${jsonEmptyCourse}      400

RegWithoutAdress
        Communication     ${jsonEmptyAdress}      400

RegWithoutIco
        Communication     ${jsonEmptyIco}      400

RegNoExistCourse
        Communication     ${jsonHightCourse}      400

RegWithoutName
        Communication     ${jsonEmptyName}      400

RegLongName
        Communication     ${jsonTooLongName}      400

RegWithoutSurname
        Communication     ${jsonEmptySurname}      400

RegWrongEmailFormat
        Communication     ${jsonWrongEmailFormat}      400

RegWrongEmailEmpty
        Communication     ${jsonEmptyEmail}      400

RegWithoutTel
        Communication     ${jsonEmptyTel}      400

RegLongName
        Communication     ${jsonTooLongTel}      400

RegShortTel
        Communication     ${jsonShortTel}      400

RegShortIco
        Communication     ${jsonShortIco}      400

RegStringIco
        Communication     ${jsonStringIco}      400

RegShortTooLongIco
        Communication     ${jsonTooLongIco}      400

RegShortWithoutPermit
        Communication     ${jsonNoPermit}      400

RegWithoutAmount
        Communication     ${jsonEmptyCount}      400

RegNullAmount
        Communication     ${jsonNullCount}      400

*** Keywords ***
Communication
        [Arguments]       ${json}     ${error_resp}
        ${resp} =          POST  ${urlapp}   data=${json}    expected_status=${error_resp}
        Log To Console         ${resp.json()}[response]
        Should Be Equal    ${resp.json()}[response]    ${error_resp}


