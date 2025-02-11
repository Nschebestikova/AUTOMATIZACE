*** Settings ***
Library	 RequestsLibrary
Library  String

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

Registrace_na_kurz
    API Comunication    {"targetid":"","kurz":"3","name":"Milena","surname":"Kováčová","email":"m.kovacova@seznam.cz","phone":"773896528","person":"fyz","address":"Karlovy Vary","ico":"","count":"1","comment":null,"souhlas":true}   200

Registrace_dlouhe_jmeno
    API Comunication    {"targetid":"","kurz":"2","name":"Peeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeetr","surname":"Jelen","email":"jelen@email","phone":"731783245","person":"fyz","address":"Brno","ico":"","count":"1","comment":null,"souhlas":true}   500

Registrace_neuvedeni_kurzu
    API Comunication    {"targetid":"","kurz":"","name":"Karla","surname":"Malá","email":"karlam@seznam.cz","phone":"731852456","person":"fyz","address":"Kladruby 31","ico":"","count":"1","comment":null,"souhlas":true}   500

Registrace_chybi_klic
    API Comunication    {"targetid":"","kurz":"2","":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace_chyby_v_JSON
    API Comunication    {"targeti":"","kurz":"2,"name":"Filip","surname":"Pucl","email":"pucl@gmail.com""phone":"721456896","person":"fyz","address":"Karlovarská 203, Plzeň","ico":"","count":"1","comment":null,"souhlas":true}  500

Registrace_specialni_znaky
    API Comunication    {"targetid":"","kurz":"2","name":"?:_*>$ßJan#","surname":"÷×÷ß¤ßNovak!?","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   200

*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}

    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}