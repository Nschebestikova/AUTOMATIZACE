
*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}
    # vytoření JSON zprávy
    ${json2}=  catenate  ${json}

    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =       POST  ${urlapp}  data=${json}   expected_status=${error_resp}



