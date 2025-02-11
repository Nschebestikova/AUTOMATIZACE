#ukol 6
*** Settings ***
Library	    RequestsLibrary
Library     String
Library     Browser


*** Variables ***
${url}		             http://testovani.kitner.cz/
${app}                   /regkurz/formsave.php
${urlapp}                ${url}${app}

${jsonOK}                {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@bbm.cz","phone":"608123120","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonbezkurzu}          {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@bbm.cz","phone":"608123120","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonbeztelefonu}       {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@bbm.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonspatnytelefon}     {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@bbm.cz","phone":"123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonspatnyemail}       {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"spatnezadanymail.cz","phone":"608123120","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${jsonspatnyformat}      {"targetid":"","kurz":"2","name":"spatny_format","surname":"Novak","email":"jan.novak@bbm.cz","phone":"608123120","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***
Úspěšná registrace
    API Comunication   ${jsonOK}               200

Registrace bez výběru kurzu
    API Comunication   {${jsonbezkurzu}        500

Registrace bez telefonu
    API Comunication   {${jsonbeztelefonu}     500

Registrace s chybným formátem telefonu
    API Comunication   {${jsonspatnytelefon}   500

Registrace s neplatným emailem
    API Comunication   {${jsonspatnyemail}     500

Registrace chyba v JSON formátu
    API Comunication   {${jsonspatnyformat}    500

*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}

    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log                 ${resp.json()}
    Status Should Be    ${error_resp}


API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8
    &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
    CreateSession       apilogin            ${url}
    ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything
    Status Should Be    ${error_resp}

