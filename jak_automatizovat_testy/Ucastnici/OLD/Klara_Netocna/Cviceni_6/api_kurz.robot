*** Settings ***
Library     RequestsLibrary


*** Variables ***
${url} 	    http://testovani.kitner.cz/
${app} 		regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***
Registrace na kurz

    ${json}=       Set Variable  {"targetid":"","kurz":"1","name":"Klarka","surname":"Testerka","email":"jan.teserkaa@data.cz","phone":"777111132","person":"fyz","address":"Udolni 21,Brno","ico":"27232493","count":"1","comment":"nic","souhlas":true}
    ${response}=    POST   ${urlapp}  data=${json}  expected_status=200
    Log To Console         ${response.ok}
    Log To Console         ${response.headers}
    Log To Console         ${response.status_code}
    Log To Console         ${response.reason}
    Log To Console         ${response.json()}[response]
    Should Be Equal        ${response.json()}[response]    200