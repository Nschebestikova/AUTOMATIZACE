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

    Registrace na kurz   1   Jan  Novák  fyz    Brno    novak@seznam.cz    123756789   1   koment  true    200

Registrace na kurz právnicka osoba - OK

    Registrace na kurz   1   Jan  Novák  pra    00551111    novak@seznam.cz    123756789   1   koment  true    500

Registrace na kurz fyzicka osoba - tel +420

    Registrace na kurz   1   Jan  Novák  fyz    Brno    novak@seznam.cz    +420123756789   1   koment  true    200

Registrace na kurz fyzicka osoba - tel bez +420

    Registrace na kurz   1   Jan  Novák  fyz    Brno    novak@seznam.cz    123756789  1   koment  true    200

Registrace na kurz fyzicka osoba bez vybraného kurzu
    Registrace na kurz   ${EMPTY}   Jan  Novák  fyz    Brno    novak@seznam.cz   123756789   1   koment  true    500

Registrace na kurz fyzicka osoba prázdné jméno
    Registrace na kurz   1   ${EMPTY}  Novák  fyz    Brno    novak@seznam.cz    123756789  1   koment  true    500

Registrace na kurz fyzicka osoba - prázdný email

    Registrace na kurz   1   Jan  Novák  fyz    Brno    ${EMPTY}    123756789   1   koment  true    500

Registrace chybny email (bez @)

    Registrace na kurz   1  Jan  Novák  fyz    Brno    novakseznam.cz    123756789   1   koment  true    500

Registrace chybne ico (pismena)
#musí být právnická osoba
    Registrace na kurz   1   Jan  Novák  pra    xy    novak@seznam.cz    123756789   1   koment  true    500


Registrace chybný JSON formát (použity <>)

    Registrace na kurz   1   Jan  Novák  fyz    Brno    <novak@seznam.cz>    123756789   1   koment  true    500


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