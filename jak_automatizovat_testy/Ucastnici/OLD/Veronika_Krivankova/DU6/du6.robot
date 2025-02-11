*** Settings ***
Library	 RequestsLibrary
Library  String

*** Variables ***
${url}		            http://testovani.kitner.cz/
${app}                  /regkurz/formsave.php
${urlapp}               ${url}${app}

${jsonOK}               {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonBezKlice}         {"targetid":"","kurz":"2","":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonBezKurzu}         {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonBeZTelefonu}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonChybnyEmail}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonChybnyFormat}     {"targetid":"","":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***
Úspěšná registrace
    API Communication   ${jsonOK}                 200

Registrace bez klíče (pouze hodnota)
    API Communication   ${jsonBezKlice}           500

Registrace bez kurzu
    API Communication   ${jsonBezKurzu}           500

Registrace bez telefonu
    API Communication   ${jsonBeZTelefonu}        500

Registrace - neplatný email
    API Communication    ${jsonChybnyEmail}       500

Registrace - chybný formát JSON
    API Communication    ${jsonChybnyFormat}      500


*** Keywords ***
API Communication
    [Arguments]       ${json}     ${error_resp}
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log                 ${resp.json()}
    Status Should Be    ${error_resp}


