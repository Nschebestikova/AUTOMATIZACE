*** Settings ***
Library               RequestsLibrary

*** Variables ***
${URL}          http://testovani.kitner.cz/
${APP}          regkurz/formsave.php
${URLAPP}       ${URL}${APP}

*** Test Cases ***
Kurzy registrace vypis

        ${json}=                  Set Variable        {"targetid":"","kurz":"1","name":"Dominik","surname":"Sieber","email":"dominik.teser@data.cz","phone":"777123132","person":"fyz","address":"U Vrsovickeho hrbitova 22,Praha 10","ico":"27232433","count":"1","comment":"nic","souhlas":true}

        ${response}=              POST        ${URLAPP}       data=${json}        expected_status=200

        Log To Console            ${response.json()}[response]
        Should Be Equal           ${response.json()}[response]    200

#Quick Get Request Test
#        ${response}=                    GET  https://www.google.com
#        Log To Console                  ${response}
#
#Quick Get Request With Parameters Test
#        ${response}=                    GET  https://www.google.com/search      params=query=ciao   expected_status=200
#
#Quick Get Request With Parameters Test
#      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=Anything
#      Status Should Be    200
##      v tuto chvíli, díky ANYTHING, to kontroluje jenon Status Should Be
#
#Quick Get A JSON Body Test
#        ${response}=                    GET  https://jsonplaceholder.typicode.com/posts/1
#        Should Be Equal As Strings      1  ${response.json()}[id]
#
#Quick Get A JSON Body Test 2
#        ${response}=                    GET  https://jsonplaceholder.typicode.com/posts/2
#        Log To Console                  ${response.json()}[id]
#        Should Be Equal As Strings      2  ${response.json()}[id]
