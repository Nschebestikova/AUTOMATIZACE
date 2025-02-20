"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

CVIČENÍ: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality +
                                                          přidejte další testy pro kompletní otestování


"""


*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
#Resource        Projekt/TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  nic  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

Registrace s nevyplneným komentarem
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  ${EMPTY}  false  200

Registrace na kurz negativni test
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  chybna_emailova_adresa  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  500


*** Keywords ***


Registrace na kurz
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${responce_code}

    # vytvoření těla (body) zprávy

    ${json}=     Catenate      {"targetid":"","kurz":"${course}",
    ...  "name":"${name}",
    ...  "surname":"${surname}",
    ...  "email":"${email}",
    ...  "phone":"${phone}",
    ...  "person":"${person}",
    ...  "address":"${address_ico}",
    ...  "ico":"${address_ico}",
    ...  "count":"${count}",
    ...  "comment":"${comment}",
    ...  "souhlas":${souhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status should be    ${responce_code}
    #nebo
    Should Be Equal As Strings	    ${resp.status_code}     ${responce_code}

    #vyhodnocení JSONu klíč response
    Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}
    #nebo
    Should Contain      ${resp.json()}[response]            ${responce_code}
























#Registrace na kurz veze s CreateSession
#    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${souhlas}  ${responce_code}
#
#    # vytvoření těla (body) zprávy
#    ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address}","ico":"1","count":"1","comment":null,"souhlas":${souhlas}}
#
#    #převedení do UTF-8
#    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String
#
#    #vytoření hlavičky (header) zprávy
#    &{header}=          Create Dictionary   Content-Type=application/json
#
#    #vytvoření spojení (session)
#    CreateSession       apilogin            ${url}
#
#    # odeslání zprávy a uložení odpovědi do ${resp}
#    ${resp} =           Post on Session     apilogin    /regkurz/formsave.php  data=${json_utf8}  headers=${header}
#    Log	                Responce: @{resp}
#
#    #vyhodnocení odpovědi a návratové hodnoty
#    Should Be Equal As Strings	    ${resp.status_code}     200
#    Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}




