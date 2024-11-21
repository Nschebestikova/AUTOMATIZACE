*** Settings ***
Library	 RequestsLibrary
Library  String

*** Variables ***
${URL}		    http://testovani.kitner.cz/
${APP}          /regkurz/formsave.php
${URL_APP}       ${URL}${APP}


*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}

   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #převedení do UTF-8

  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8       #vytoření hlavičky (header) zprávy

  CreateSession       apilogin            ${url}        #vytvoření spojení (session)

  #odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}

API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}

   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  CreateSession       apilogin            ${url}

  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}


*** Test Cases ***
Uspesna registrace
    API Comunication   {"targetid":"","kurz":"2","name":"Ivan","surname":"Malý","email":"ivan@email.cz","phone":"999888777","person":"fyz","address":"Ostrava","ico":"987654321","count":"1","comment":null,"souhlas":true}  200

Dlouhe tel. cislo
    API Comunication   {"targetid":"","kurz":"3","name":"Milan","surname":"Milý","email":"milan@email.cz","phone":"111222333444555","person":"fyz","address":"Plzeň","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Chybejici jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"","surname":"Veselý","email":"vesely@email.cz","phone":"999888777","person":"fyz","address":"Opava","ico":"987654321","count":"1","comment":null,"souhlas":true}  200

Prazdna hodnota (kurz)
    API Comunication   {"targetid":"","kurz":"","name":"Iva","surname":"Šťastná","email":"iva@email.cz","phone":"111222333","person":"fyz","address":"Praha","ico":"","count":"1","comment":null,"souhlas":true}  500

Specialni znaky
    API Comunication   {"targetid":"","kurz":"5","name":"Le%","surname":"+alá","email":"lea@email.cz","phone":"999111666","person":"fyz","address":"Jihlava","ico":"444555666","count":"1","comment":null,"souhlas":true}  200

Chybny formar JSON ("targetid"::"")
    API Comunication   {"targetid"::"","kurz":"2","name":"Jitka","surname":"Tichá","email":"jitka@email.cz","phone":"555555555","person":"fyz","address":"Tábor","ico":"987654322","count":"1","comment":null,"souhlas":true}  200

