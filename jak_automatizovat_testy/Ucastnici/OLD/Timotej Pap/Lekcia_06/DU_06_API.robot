*** Settings ***
Library         RequestsLibrary
Library         String

*** Variables ***
${URL}                  http://testovani.kitner.cz
${APP}                  /regkurz/formsave.php
${URLAPP}               ${URL}${APP}

*** Test Cases ***

Registration OK
    API requests            {"targetid":"","kurz":"2","name":"Igor","surname":"Hnizdo","email":"igor.hnizdo@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

Registration empty course
    API requests            {"targetid":"","kurz":"","name":"Igor","surname":"Hnizdo","email":"igor.hnizdo@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registration wrong e-mail
    API requests            {"targetid":"","kurz":"2","name":"Igor","surname":"Hnizdo","email":"igor.hnizdo!abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500

Registration no key
    API requests            {"targetid":"","kurz":"2","name":"Igor","surname":"Hnizdo","":"igor.hnizdo@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500

Registration incorrect JSON
    API requests            {"targetid":"","kurz":"2","name":"Igor","surname":"Hnizdo","email":"igor.hnizdo@abc.cz","phone":(608123123),"person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500

*** Keywords ***
API requests
    [Arguments]         ${json}     ${response}
    ${resp} =           POST        ${URLAPP}   data=${json}        expected_status=${response}
    ${json_utf8} =      Encode String To Bytes  ${json}             UTF-8          #vyžaduje knihovnu String
    ${resp} =           POST        ${URLAPP}   data=${json_utf8}   expected_status=${response}
    Log                 ${resp.json()}
    Status Should Be    ${response}