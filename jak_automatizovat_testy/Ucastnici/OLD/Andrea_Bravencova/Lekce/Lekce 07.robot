
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

Registrace na kurz FO
     Registrace na kurz  2  Jan  Novakščěší  fyz  Brno  jan.novak@abc.cz  608123123  1  null  true  500




*** Keywords ***
Registrace na kurz
   [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${responce_code}


   # vytvoření těla (body) zprávy


   ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}


   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String


   #vytoření hlavičky (header) zprávy
   &{header}=          Create Dictionary   Content-Type=application/json


   # odeslání zprávy a uložení odpovědi do ${resp}
   ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything
   Log                    Responce: @{resp}


   #vyhodnocení status kódu
   Status should be    ${responce_code}
   #nebo
   Should Be Equal As Strings     ${resp.status_code}     ${responce_code}


   #vyhodnocení JSONu klíč response
   Dictionary Should Contain Item ${resp.json()}          response    ${responce_code}
   #nebo
   Should Contain      ${resp.json()}[response]            ${responce_code}





