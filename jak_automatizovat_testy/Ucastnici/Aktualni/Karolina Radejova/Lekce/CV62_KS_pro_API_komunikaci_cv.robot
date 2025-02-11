
*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

Registrace ok
    API Comunication    {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String
    ${resp} =          POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Should Be Equal As Strings    ${resp.json()}[response]    ${error_resp}







