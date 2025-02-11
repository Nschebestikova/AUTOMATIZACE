*** Settings ***
Library               RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***
Registrace na kurz
      ${json} =  Set Variable  {"targetid":"","kurz":"1","name":"Jan","surname":"DNESKATester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

      ${response}=    POST   ${urlapp}  data=${json}  expected_status=200

      Status Should Be    200

      Log To Console    >>>${response.json()}[response]
      Should Be Equal    ${response.json()}[response]    200