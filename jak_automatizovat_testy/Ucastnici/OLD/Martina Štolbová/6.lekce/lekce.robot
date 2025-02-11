*** Settings ***
Library               RequestsLibrary

*** Test Cases ***
Quick Get Request Test
      ${response}=    GET  https://www.google.com
      Log to console    ${response}

Quick Get Request With Parameters Test
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
      Status should be    200
Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
      Log to Console    ${response.json ()}[id]
      Should Be Equal As Strings  2   ${response.json()}[id]

${json} =  Set Variable  {"targetid":"","kurz":"1","name":"Jan","surname":"DNESKATester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

      ${response}=    POST   ${urlapp}  data=${json}  expected_status=200

      Status Should Be    200

      Log To Console    >>>${response.json()}[response]
      Should Be Equal    ${response.json()}[response]    200
*** Variables ***
${url}      http://testovani/kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}