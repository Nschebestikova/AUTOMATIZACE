#"""

#Tento příklad potřebuje robotframework-requests balíček
#instalace:
#pip install robotframework-requests

#CVIČENÍ 2: vytvořte další testy, 1 pozitivní a 1 negativní test


#"""


*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

Registrace uzivatele fyzicka osoba
    Registrace na kurz      kurz     jmeno      prijmeni    pra_fyz   adresa_ico=adresa    email   telefon     pocet_osob  komentar    souhlas

Registrace uživatele pravnicka osoba
    Registrace na kurz      kurz     jmeno      prijmeni    pra_fyz   adresa_ico=ico    email   telefon     pocet_osob  komentar    souhlas

registrace ok
    API Comunication    {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace bez volby kurzu
    API Comunication    {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace volby telefonu (prázdný)
    API Comunication    {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunication    {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"1234567890123456","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny email (tohleneniemail.cz)
    API Comunication    {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy  "kurz":"2")
   API Comunication    {"targetid":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200


#BONUS: registrace chybny format JSON (vymyslet jinou chybu JSON dat) např scházející uvozovky nebo složené závorky
#přidat test


*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}
    Log                 ${resp.json()}[response]

    IF    "${resp.json()}[response]" != "200"
        Log                 ${resp.json()}[reason]
        Log                 ${resp.json()}[problem]

    END

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



Registrace na kurz
#todo
#    [Arguments]    ${kurz}     ${jmeno}      ${prijmeni}    ${pra_fyz}   ${adresa_ico}    ${email}   ${telefon}     ${pocet_osob}  ${komentar}    ${souhlas}   ${error_resp}

    #IF    ${pra_fyz} == "pra"
    #    Call Keyword
    #ELSE
    #
    #END

#    ${json} =   Set Variable  {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni}","person":"${pra_fyz}","ico":"${adresa_ico}","email":"${email}","phone":"${telefon}","count":"${pocet_osob}","comment":"${komentar}","souhlas":${souhlas}}
#    ${resp} =           POST  ${urlapp}   data=${json}    expected_status=${error_resp}

#pokud česky, překodovat utf-8, přidat if else na ičo/adresu, přehodit jednotlivé elementy, přidat parametr error code

