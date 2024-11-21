#"""
#Tento příklad potřebuje robotframework-requests balíček
#instalace:
#pip install robotframework-requests

#CVIČENÍ 2: vytvořte další testy, 1 pozitivní a 1 negativní test
#"""
*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
#Library	 Collections

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}
# http://testovani.kitner.cz/regkurz/formsave.php

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
*** Test Cases ***
Registrace - uspech
    API Comunication    {"targetid":"","kurz":"2","name":"Dominik01","surname":"Sieberščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

#ty 500 by tu nemeli byt, ale 400 kody
Registrace - kurz chyba (prázdný)
    API Comunication    {"targetid":"","kurz":"","name":"Dominik02","surname":"Sieber02","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registrace - telefon chyba (prázdný)
    API Comunication    {"targetid":"","kurz":"","name":"Dominik03","surname":"Sieber03","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   400

Registrace - telefon chyba (moc dlouhy)
    API Comunicaication Post on Session    {"targetid":"","kurz":"2","name":"Dominik04","surname":"Sieber04","email":"jan.novak@abc.cz","phone":"+420608123123999","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    400

Registrace - email format chyba (tohleneniemail.cz)
    API Comunicaication Post on Session    {"targetid":"","kurz":"2","name":"Dominik05","surname":"Sieber05","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    400

Registrace - JSON format chyba (bez klíče a hodnoty kurzu)
    API Comunication    {"targetid":"", "name":"Dominik06","surname":"Sieber06","email":"jan.novak@abc.czz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    400

BONUS: Registrace - JSON format chyba (vymyslet jinou chybu JSON dat) např scházející uvozovky nebo složené závorky
    API Comunicaication Post on Session    {"targetid":"", "kurz":"2", "name":Dominik07,"surname":"Sieber07","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    400

*** Keywords ***

API Comunication
    [Arguments]       ${json}           ${error_resp}
    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes          ${json}                 UTF-8          #vyžaduje knihovnu String
    ${resp} =           POST        ${urlapp}       data=${json_utf8}       expected_status=${error_resp}
    Log                 ${resp.json()}
    Status Should Be    ${error_resp}

API Comunicaication Post on Session
    [Arguments]       ${json}           ${error_resp}
    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes            ${json}          UTF-8          #vyžaduje knihovnu String
    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary             Content-Type=application/json           charset=utf-8
    #vytvoření spojení (session)
    CreateSession       apilogin                  ${url}
    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}=        Post on Session     apilogin     ${app}     data=${json_utf8}     headers=${header}     expected_status=Anything
    Status Should Be    ${error_resp}

