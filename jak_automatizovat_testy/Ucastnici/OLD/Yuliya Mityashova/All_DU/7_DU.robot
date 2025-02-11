*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***

Registrace na kurz FO
   Registrace na kurz  2  Jan  Novakščěší   jan.novak@abc.cz   608123123   fyz   Udolni 21, Brno    1   null   true   200

Registrace na kurz PO
   Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz  608123123  pra  27232433  1  hello  false  200

Registrace na kurz nevyplnene povinne pole - nazev kurzu
    Registrace na kurz  ${EMPTY}  Jan  Novak  jan.novak@abc.cz  608123123  fyz  Udolni 21, Brno  1  cau  true  500

Registrace na kurz nevyplnene povinne pole - jmeno
    Registrace na kurz  2  ${EMPTY}  Novak  jan.novak@abc.cz  608123123  fyz  Udolni 21, Brno  1  ahoj  false  500

Registrace na kurz nevyplnene povinne pole - prijmeni
    Registrace na kurz  2  Jan  ${EMPTY}  jan.novak@abc.cz  608123123  fyz  Udolni 21, Brno  1  hola  false  500

Registrace na kurz nevyplnene povinne pole - email
    Registrace na kurz  2  Jan  Novak  ${EMPTY}  608123123  fyz  Udolni 21, Brno  1  salam  false  500

Registrace na kurz nevyplnene povinne pole - tel cislo
    Registrace na kurz  2  Jan  Novak  jan.novak@abc.cz  ${EMPTY}  fyz  Udolni 21, Brno  1  mehraba  true  500

Registrace na kurz spatny format tel cisla
    Registrace na kurz  2  Jan  Novak  jan.novak@abc.cz  /telYM  fyz  Udolni 21, Brno  1  ciao  false  500

Registrace na kurz spatny format emailu
    Registrace na kurz  2  Jan  Novak  jan.novak@abc  608123123  fyz  Udolni 21, Brno  1  nazdar  true   500

Registrace na kurz spatny format ICO
    Registrace na kurz  2   Jan  Novak  jan.novak@abc  608123123  pra  2345632  1   privet   false   500

Registrace na kurz spatny format JSONu
   Registrace na kurz   null  Jan  Novak  jan.novak@abc.cz  608123123  fyz  Udolni 21, Brno  1  nazdar  true   500

*** Keywords ***
Registrace na kurz
    [Arguments]    ${course}  ${name}    ${surname}    ${e-mail}    ${telephone_number}    ${person}    ${ico_adress}    ${count}    ${comment}    ${agreement}    ${expected_status}
    Log To Console    \nSending Request To ${urlapp}\n
    ${jsonBody}      Catenate    {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${e-mail}","phone":"${telephone_number}","person":"${person}","address":"${ico_adress}","ico":"${ico_adress}","count":"${count}","comment":"${comment}","souhlas":${agreement}}
    ${json_utf8}     Encode String To Bytes     ${jsonBody}     UTF-8
    &{header}        Create Dictionary   Content-Type=application/json
    ${resp}  POST   url=${urlapp}  data=${json_utf8}  headers=${header}  expected_status=${expected_status}
    Log	                Responce: @{resp}
    Should Contain      ${resp.json()}[response]     ${expected_status}