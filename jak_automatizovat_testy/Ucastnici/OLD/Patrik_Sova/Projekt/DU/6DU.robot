*** Settings ***
Metadata    Author    Patrik Sova
Metadata    Purpose   API test
Metadata    Created   16.1.2024

*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
#Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"1","name":"Patrik","surname":"Tester","email":"patrik.tester@test.cz","phone":"777123456","person":"fyz","address":"Horni 21,Opava","ico":"78992433","count":"1","comment":"nic","souhlas":true}  200

registrace vyšší číslo kurzu
    API Comunication   {"targetid":"","kurz":"5","name":"Patrik","surname":"Tester","email":"aptrik.tester@test.cz","phone":"777123132","person":"fyz","address":"Nad Kometou 87,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}   500

registrace prádzné jméno
    API Comunication   {"targetid":"","kurz":"3","name":"","surname":"Tester","email":"xxx.tester@test.cz","phone":"666123132","person":"fyz","address":"Pod rybnikem 21,Ostrava","ico":"27232433","count":"1","comment":"nic","souhlas":true}   500

registrace špatný mail format
    API Comunication   {"targetid":"","kurz":"3","name":"Pavel","surname":"Tester","email":"jan.testerdata.cz","phone":"777123132","person":"fyz","address":"Divoky zapad 21,Kroměříž","ico":"27232433","count":"1","comment":"nic","souhlas":true}  500

registrace prazdný mobil
    API Comunication   {"targetid":"","kurz":"3","name":"Pepa","surname":"Tester","email":"pepa.tester@test.cz","phone":"","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}  500


registrace dlouhe mobilní číslo
    API Comunication   {"targetid":"","kurz":"1","name":"Erik","surname":"Tester","email":"erik.tester@test.cz","phone":"6661231325667868699","person":"fyz","address":"NEvim co 25,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}  500

registrace - prazdne ico
    API Comunication   {"targetid":"","kurz":"1","name":"Trpaslik","surname":"Tester","email":"trpaslik.tester@test.cz","phone":"777123132","person":"fyz","address":"Tady dole,Brno","ico":"","count":"1","comment":"nic","souhlas":true}  500

registrace - kratke ico
    API Comunication   {"targetid":"","kurz":"1","name":"Batman","surname":"Tester","email":"barman.teser@test.cz","phone":"666123132","person":"fyz","address":"Hej ty,Brno","ico":"272324","count":"1","comment":"nic","souhlas":true}  500



*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}
#    Log To Console      ${json}
#    Log To Console      ${resp}
#    Log To Console      ${json_utf8}

    Status Should Be    ${error_resp}
    Status Should Be    ${error_resp}


API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}
