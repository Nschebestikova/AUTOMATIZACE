
*** Settings ***
Library  RequestsLibrary
Library  String

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***
Registrace uzivatele fyz
    Registrace na kurz   1  klara  netocna  Udolni 21, Brno  fyz  klara.testeer@data.cz  776111444  1  komentar  true   200


Registrace uzivatele prav
    Registrace na kurz    1  klara  novotna  2723243  prav  klara.testerka@data.cz  777111944  1  komentar  true   200

*** Keywords ***
Registrace na kurz
    [Arguments]          ${kurz}  ${jmeno}  ${prijmeni}  ${ico_adresa}  ${prav_fyz}  ${email}  ${telefon}  ${pocet_os}  ${komentar}  ${souhlas}  ${error_resp}
    ${json}=       Set Variable  {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${telefon}","person":"${prav_fyz}","address":"${ico_adresa}","ico":"${ico_adresa}","count":"${pocet_os}","comment":"${komentar}","souhlas":${souhlas}}
    ${resp} =          POST  ${urlapp}  data=${json}    expected_status=Anything
    Status Should Be    ${error_resp}