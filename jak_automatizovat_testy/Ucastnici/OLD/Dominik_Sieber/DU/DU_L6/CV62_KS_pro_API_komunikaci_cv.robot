*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php/
${urlapp}   ${url}${app}
#${json}     {"targetid":"","kurz":"1","name":"Dominik2","surname":"Sieber2","email":"dominik2.sieber2@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}             200

*** Test Cases ***
Registrace ok
    API Comunication    {"targetid":"","kurz":"1","name":"Dominik2","surname":"Sieber2","email":"dominik2.sieber2@data.cz","phone":"777123132", "person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}             200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Dominik3","surname":"Sieber3","email":"domnik3.sieber3@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}                       500

*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String a tím se povolí ceske znaky

    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =          POST     ${urlapp}       data=${json}        expected_status=${error_resp}

    Status Should Be   ${error_resp}

    Log   ${resp.json()}