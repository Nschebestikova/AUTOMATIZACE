*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}




*** Test Cases ***

Prvni API test
      ${JSON}=  Set Variable      {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

      ${json_utf8} =    Encode String To Bytes     ${json}          UTF-8          #vyžaduje knihovnu String
      ${response}=      POST   ${urlapp}           data= ${JSON}

      Status Should Be  200
      Log to Console    ${response}

