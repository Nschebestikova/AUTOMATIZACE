
*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***

Registrace na kurz fyzicka osoba - OK

    Registrace na kurz   1   Franta  Opička  fyz    Brno    opicak@seznam.cz    678901234   1   koment  true    200

Registrace na kurz právnicka osoba - OK

    Registrace na kurz   1   Franta  Opička  pra    00551023    opicak@seznam.cz    678901234   1   koment  true    200

Registrace na kurz fyzicka osoba - tel +420

    Registrace na kurz   1   Franta  Opička  fyz    Brno    opicak@seznam.cz    +420678901234   1   koment  true    200

Registrace na kurz fyzicka osoba - tel bez +420

    Registrace na kurz   1   Franta  Opička  fyz    Brno    opicak@seznam.cz    678901234   1   koment  true    200

Registrace na kurz fyzicka osoba bez vybraného kurzu
    Registrace na kurz   ${EMPTY}   Franta  Opička  fyz    Brno    opicak@seznam.cz    678901234   1   koment  true    500

Registrace na kurz fyzicka osoba prázdné jméno
    Registrace na kurz   1   ${EMPTY}  Opička  fyz    Brno    opicak@seznam.cz    678901234   1   koment  true    500

Registrace na kurz fyzicka osoba - prázdný email

    Registrace na kurz   1   Franta  Opička  fyz    Brno    ${EMPTY}    678901234   1   koment  true    500

Registrace chybny email (bez @)

    Registrace na kurz   1   Franta  Opička  fyz    Brno    opicakseznam.cz    678901234   1   koment  true    500

Registrace chybne ico (pismena)
#musí být právnická osoba
    Registrace na kurz   1   Franta  Opička  pra    aaaaaaaa    opicak@seznam.cz    678901234   1   koment  true    500


Registrace chybný JSON formát (použity <>)

    Registrace na kurz   1   Franta  Opička  fyz    Brno    <opicak@seznam.cz>    678901234   1   koment  true    500


*** Keywords ***



Registrace na kurz
    [Arguments]       ${cislo_kurzu}  ${jmeno}  ${prijmeni}  ${fyz_pra}  ${adresa_ico}  ${email}  ${telefon}  ${poc_osob}  ${koment}  ${souhlas}  ${error_resp}
    # vytvoření těla (body) zprávy
    ${json}=  Catenate  {"targetid":"","kurz":"${cislo_kurzu}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${telefon}","person":"${fyz_pra}","address":"${adresa_ico}","ico":"${adresa_ico}","count":"${poc_osob}","comment":"${koment}","souhlas":"${souhlas}"}
    #převedení do UTF-8
    ${json_utf8}=   Encode String To Bytes    ${json}    UTF-8
    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json
    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =          POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log   Response: @{resp}
    #vyhodnocení status kódu
    Should Contain      ${resp.json()}[response]     ${error_resp}