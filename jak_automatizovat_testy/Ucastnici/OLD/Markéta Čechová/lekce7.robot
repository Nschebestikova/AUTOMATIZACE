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

    Registrace na kurz   1   Franta  Opička  fyz    Brno    opicak@seznam.cz    678901234   1   koment  true    200

Registrace na kurz právnicka osoba

    Registrace na kurz   1   Franta  Opička  pra    00551023    opicak@seznam.cz    678901234   1   koment  true    200

Registrace na kurz fyzicka osoba - tel +420

    Registrace na kurz   1   Franta  Opička  fyz    Brno    opicak@seznam.cz    +420678901234   1   koment  true    200

Registrace na kurz fyzicka osoba bez vybraného kurzu
    Registrace na kurz   ${EMPTY}   Franta  Opička  fyz    Brno    opicak@seznam.cz    678901234   1   koment  true    500


Registrace na kurz fyzicka osoba prázdné jméno
    Registrace na kurz   1   ${EMPTY}  Opička  fyz    Brno    opicak@seznam.cz    678901234   1   koment  true    500



*** Keywords ***
# Klíčové slovo pro registraci na kurz z pohledu funčnosti, tedy uživatele


#Registracena kurz
 #   [Arguments]   ${cislo_kurzu}    ${jmeno}    ${prijmeni}     ${osoba}     ${adresa_ico}  ${email}    ${telefon}  ${pocet_osob}   ${koment}   ${souhlas} #Doplněte parametry

    # vytvoření těla (body) zprávy
  #  ${json} = {"targetid":"","kurz":"${cislo_kurzu}","name":"${jmeno}","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

    #převedení do UTF-8
   # ${json_utf8} =      Encode String To Bytes      ${json}     UTF-8
    #vytoření hlavičky (header) zprávy

    # odeslání zprávy a uložení odpovědi do ${resp}

    #vyhodnocení status kódu

    #vyhodnocení JSONu klíč response



Registrace na kurz
    [Arguments]       ${cislo_kurzu}  ${jmeno}  ${prijmeni}  ${fyz_pra}  ${adresa_ico}  ${email}  ${phone}  ${poc_osob}  ${koment}  ${souhlas}  ${error_resp}
    ${json}=  Catenate  {"targetid":"","kurz":"${cislo_kurzu}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${phone}","person":"${fyz_pra}","address":"${adresa_ico}","ico":"${adresa_ico}","count":"${poc_osob}","comment":"${koment}","souhlas":"${souhlas}"}
    ${json_utf8}=   Encode String To Bytes    ${json}    UTF-8
    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    ${resp} =          POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log   ${resp.json()}
    Status Should Be   ${error_resp}
