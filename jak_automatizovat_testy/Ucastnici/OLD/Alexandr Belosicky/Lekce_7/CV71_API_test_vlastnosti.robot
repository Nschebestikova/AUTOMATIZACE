"""
Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

CVIČENÍ1: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality, jak ověřovat

CVIČENÍ2  Vytvořte testy pro kompletní otestování - registrace z pohledů funkcí/vlastností
            inspirace web aplikace http://testovani.kitner.cz/regkurz/
"""

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***
Registrace na kurz fyzicka osoba - devítimístné tel. číslo - pozitivní
    Registrace na kurz  1  Karel  Novák  fyz  Brno  karel.novak@seznam.cz  777666555  1  komentar  true  200

Registrace na kurz fyzicka osoba - tel. číslo s +420 - pozitivní
    Registrace na kurz  1  Karel  Novák  fyz  Brno  karel.novak@seznam.cz  +420777666555  1  komentar  true  200

Registrace na kurz fyzicka osoba - chybí kurz
    Registrace na kurz  ${empty}  Karel  Novák  fyz  Brno  karel.novak@seznam.cz  777666555  1  komentar  true  500

Registrace na kurz fyzicka osoba - chybí jméno
    Registrace na kurz  1  ${empty}  Novák  fyz  Brno  karel.novak@seznam.cz  777666555  1  komentar  true  500

Registrace na kurz fyzicka osoba - chybí příjmení
    Registrace na kurz  1  Karel  ${empty}  fyz  Brno  karel.novak@seznam.cz  777666555  1  komentar  true  500

Registrace na kurz fyzicka osoba - chybí příjmení
    Registrace na kurz  1  Karel  ${empty}  fyz  Brno  karel.novak@seznam.cz  777666555  1  komentar  true  500

Registrace na kurz pravnická osoba
    Registrace na kurz  1  Karel  Novák  pra  45274649  karel.novak@seznam.cz  777666555  1  komentar  true  200

*** Keywords ***
Registrace na kurz
    [Arguments]       ${cislo_kurzu}  ${jmeno}  ${prijmeni}  ${fyz_pra}  ${adresa_ico}  ${email}  ${phone}  ${poc_osob}  ${koment}  ${souhlas}  ${error_resp}
    ${json} =  Catenate  {"targetid":"","kurz":"${cislo_kurzu}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${phone}","person":"${fyz_pra}","address":"${adresa_ico}","ico":"${adresa_ico}","count":"${poc_osob}","comment":"${koment}","souhlas":"${souhlas}"}
    ${json_utf8} =   Encode String To Bytes   ${json}    UTF-8

 #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    ${resp} =        POST  ${urlapp}  data=${json_utf8}  headers=${header}  expected_status=Anything
    Log   ${resp.json()}
    Status Should Be   ${error_resp}
    Should Contain      ${resp.json()}[response]            ${error_resp}



