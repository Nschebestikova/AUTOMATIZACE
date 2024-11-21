*** Settings ***
Library	 RequestsLibrary
Library  String

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}


*** Test Cases ***
Registration OK
    API Communication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

Registartion NOK - missing course
    API Communication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registration NOK - missing phone number
    API Communication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registration NOK - missing name
   API Communication  {"targetid":"","kurz":"2","name":"","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registration NOK - missing address city
   API Communication  {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registration NOK - incorrect email
   API Communication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novakabc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registration NOK - incorrect JSON format
   API Communication   {"targetid":"","kurz":{2}","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

*** Keywords ***
API Communication
    [Arguments]       ${json}     ${error_resp}
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log                 ${resp.json()}
    Status Should Be    ${error_resp}