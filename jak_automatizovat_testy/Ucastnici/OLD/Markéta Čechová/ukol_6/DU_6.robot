*** Settings ***
Library  RequestsLibrary
Library  String

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

Registrace fyzicka osoba ok
    API Communication   {"targetid":"","kurz":"2","name":"Fanda","surname":"Opička","email":"fanda@opicka.cz","phone":"607123456","person":"fyz","address":"Opičákov","ico":"234563234","count":"1","comment":null,"souhlas":true}   200

Registrace pravnicka osoba ok
    API Communication   {"targetid":"","kurz":"2","name":"Fanda","surname":"Opička","email":"fanda@opicka.cz","phone":"607123456","person":"pra","address":"Opičákov","ico":"00551023","count":"1","comment":null,"souhlas":true}   200

Registrace bez kurzu
    API Communication   {"targetid":"","kurz":"","name":"Fanda","surname":"Opička","email":"fanda@opicka.cz","phone":"607123456","person":"fyz","address":"Opičákov","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registrace bez jmena
    API Communication   {"targetid":"","kurz":"2","name":"","surname":"Opička","email":"fanda@opicka.cz","phone":"607123456","person":"fyz","address":"Opičákov","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registrace bez telefonu
    API Communication   {"targetid":"","kurz":"2","name":"Fanda","surname":"Opička","email":"fanda@opicka.cz","phone":"","person":"fyz","address":"Opičákov","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registrace specialni znak ve jmene
    API Communication   {"targetid":"","kurz":"2","name":"Fanda@@","surname":"Opička","email":"fanda@opicka.cz","phone":"607123456","person":"fyz","address":"Opičákov","ico":"234563234","count":"1","comment":null,"souhlas":true}   200

Registrace chybny email (bez @)
    API Communication   {"targetid":"","kurz":"2","name":"Fanda","surname":"Opička","email":"fandaopicka.cz","phone":"607123456","person":"fyz","address":"Opičákov","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registrace chybne ico (pismena)
    #musí být právnická osoba
    API Communication   {"targetid":"","kurz":"2","name":"Fanda","surname":"Opička","email":"fanda@opicka.cz","phone":"607123456","person":"pra","address":"Opičákov","ico":"abcdefghi","count":"1","comment":null,"souhlas":true}   500

Registrace chybný JSON formát (použity <>)
    API Communication   {<targetid>:"",<kurz>:"2","name":"Fanda","surname":"Opička","email":"fanda@opicka.cz","phone":"607123456","person":"fyz","address":"Opičákov","ico":"234563234","count":"1","comment":null,"souhlas":true}   500







*** Keywords ***

API Communication
    [Arguments]         ${json}                     ${error_resp}
    ${json_utf8} =      Encode String To Bytes      ${json}     UTF-8
    ${resp} =           POST  ${urlapp}             data=${json_utf8}           expected_status=${error_resp}
    Log                 ${resp.json()}
    Status Should Be    ${error_resp}