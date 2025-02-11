#CVIČENÍ1: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality, jak ověřovat

#CVIČENÍ2  Vytvořte testy pro kompletní otestování - registrace z pohledů funkcí/vlastností
#            inspirace web aplikace http://testovani.kitner.cz/regkurz/

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***
Registracia na kurz fyzicka osoba
    Registracia na kurz    3    Igor    Hnizdo    igor@hnizdo.com    777365985    fyz    Poprad    1    registracia    true    200

Registracia na kurz zly email
    Registracia na kurz    1    Timo    Pap    timo_pap#gmail.com    090000055    fyz    Poprad    2    nejaky komentar    false    500

Registracia na kurz prazdny komentar
    Registracia na kurz    2    Stefan    Hrib    stefan_hrib@centrum.sk    090478654    fyz    Bratislava    1    ${EMPTY}    true    200

Registracia na kurz prazdne meno
    Registracia na kurz    2    ${EMPTY}    Pap    timo_pap@gmail.com    908565893    fyz     Lucenec    2    komentar    false    500

Registracia na kurz zly telefon
    Registracia na kurz    3    Peter    Horak    peter_horak@gmail.com    +++52489647522    pra    31576753    1    ${EMPTY}    false    500


*** Keywords ***
# Klíčové slovo pro registraci na kurz z pohledu funkčnosti, tedy uživatele

Registracia na kurz
    [Arguments]     ${c_kurzu}    ${meno}    ${priezvisko}    ${email}   ${telefon}    ${fyz_pra}    ${adresa_ico}   ${poc_osob}   ${komentar}  ${suhlas}   ${expected_status}

    # vytvoření těla (body) zprávy
    ${json} =   Catenate    {"targetid":"","kurz":"${c_kurzu}","name":"${meno}","surname":"${priezvisko}","email":"${email}","phone":"${telefon}","person":"${fyz_pra}","address":"${adresa_ico}","ico":"${adresa_ico}","count":"${poc_osob}","comment":"${komentar}","souhlas":"${suhlas}"}

    # převedení do UTF-8
    ${json_utf8} =          Encode String To Bytes  ${json}             UTF-8

    # vytvoření hlavičky (header) zprávy
    &{header} =  Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =    POST       ${URLAPP}   data=${json_utf8}   headers=${header}  expected_status=Anything
    Log                     ${resp.json()}

    # vyhodnocení status kódu
    Status Should Be        ${expected_status}

    # vyhodnocení JSONu klíč response
    Dictionary Should Contain Item  ${resp.json()}          response    ${expected_status}
    # nebo
    Should Contain                  ${resp.json()}[response]            ${expected_status}
