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
Registrace na kurz fyzicka osoba
    Registrace na kurz   1  Karel  Novak  fyz  Brno  karel.novak@seznam.cz  777111111  1  komentar  true  200
# zde budou testy např: Registrace na kurz fyzicka osoba
Registrace na kurz pravnicka osoba
    Registrace na kurz   1  Karel  Novak  pra  45274649  karel.novak@seznam.cz  777111111  1  komentar  true  200



*** Keywords ***
# Klíčové slovo pro registraci na kurz z pohledu funčnosti, tedy uživatele

Registrace na kurz
    [Arguments]       ${cislo_kurzu}  ${jmeno}  ${prijmeni}  ${fyz_pra}  ${adresa_ico}  ${email}  ${phone}  ${poc_osob}  ${koment}  ${souhlas}  ${error_resp}
    ${json} =  Catenate  {"targetid":"","kurz":"${cislo_kurzu}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${phone}","person":"${fyz_pra}","address":"${adresa_ico}","ico":"${adresa_ico}","count":"${poc_osob}","comment":"${koment}","souhlas":"${souhlas}"}
    ${json_utf8} =   Encode String To Bytes   ${json}  UTF-8
    ${resp} =          POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    &{header}=          Create Dictionary   Content-Type=application/json
    Log   ${resp.json()}
    Status Should Be   ${error_resp}
    # vytvoření těla (body) zprávy

    #převedení do UTF-8

    #vytoření hlavičky (header) zprávy

    # odeslání zprávy a uložení odpovědi do ${resp}

    #vyhodnocení status kódu

    #vyhodnocení JSONu klíč response






