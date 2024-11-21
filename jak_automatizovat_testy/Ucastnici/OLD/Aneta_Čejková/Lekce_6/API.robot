*** Settings ***
Library	 RequestsLibrary
Library  String


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}


*** Test Cases ***
registrace - pozitivní
    API Communication   {"targetid":"","kurz":"2","name":"Andy","surname":"Dvořáková","email":"andy.dvorak@seznam.cz","phone":"123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace - negativní
    API Communication   {"targetid":"","kurz":"2","name":"@Andy","surname":"Dvořáková","email":"andy.dvorak&seznam.cz","phone":"123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

hraniční hodnoty (moc dlouhé jmeno/číslo)
    API Communication   {"targetid":"","kurz":"2","name":"Andy","surname":"Dvořáková","email":"andy.dvorak@seznam.cz","phone":"00000000123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

prázdné hodnoty
    API Communication   {"targetid":"","kurz":"","name":"Andy","surname":"Dvořáková","email":"andy.dvorak@seznam.cz","phone":"123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

vynechané povinné klíče (bez klíče kurz)
    API Communication   {"targetid":"",:"2","name":"Jan","surname":"Dvořáková","email":"jan.novak@abc.cz","phone":"123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

chyby v JSON formátu (bez klíče a hodnoty kurzu)
    API Communication   {"targetid":"","name":"Andy","surname":"Dvořáková","email":"andy.dvorak@seznam.cz","phone":"123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
    Log To Console    ${urlapp}

speciální znaky'*'
    API Communication   {"targetid":"","kurz*":"2","name":"Andy","surname":"Dvořáková","email":"andy.dvorak@seznam.cz","phone":"123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500


*** Keywords ***
API Communication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}


API Communication Post on Session
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

    #vytvoření spojení (session)
    CreateSession       apilogin            ${url}

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}=   POST On Session    apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

    Status Should Be    ${error_resp}    #vyhodnocení