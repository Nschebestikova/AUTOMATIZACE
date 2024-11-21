*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***
Registrace na kurz - fyzicka osoba
    Registrace na kurz   1  Jiri  Silbersky  fyzicka  Brno  jsilbersky@gmail.com  731822307  1  komentar  true  200
# zde budou testy např: Registrace na kurz fyzicka osoba
Registrace na kurz - pravnicka osoba
    Registrace na kurz   1  Jiri  Silbersky  pravnicka  45274649  jsilbersky@gmail.com  731822306  1  komentar  true  200


*** Keywords ***


Registrace na kurz
    [Arguments]       ${cislo_kurzu}  ${jmeno}  ${prijmeni}  ${fyzicka_pravnicka}  ${adresa_ico}  ${email}  ${phone}  ${pocet_osob}  ${koment}  ${souhlas}  ${error_resp}
    ${json} =  Catenate  {"targetid":"","kurz":"${cislo_kurzu}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${phone}","person":"${fyzicka_pravnicka}","address":"${adresa_ico}","ico":"${adresa_ico}","count":"${pocet_osob}","comment":"${koment}","souhlas":"${souhlas}"}
    ${json_utf8} =   Encode String To Bytes   ${json}  UTF-8
    ${resp} =          POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    &{header}=          Create Dictionary   Content-Type=application/json
    Log   ${resp.json()}
    Status Should Be   ${error_resp}
