
*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

Registrace ok
   ${json}=  Catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Total","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
   ${response}=    POST  ${urlapp}  data=${json}
   Status Should Be    200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}


    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =          POST  ${urlapp}  data=${json}  expected_status=${error_resp}







