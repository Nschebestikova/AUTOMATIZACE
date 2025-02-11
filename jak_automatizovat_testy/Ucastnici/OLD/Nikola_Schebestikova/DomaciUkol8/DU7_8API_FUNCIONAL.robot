
*** Settings ***
Library	    RequestsLibrary
Library     String
Library     Collections
Library     DebugLibrary

# TEXT SOUBOR, VE KTERÉM JE DOKUMENTACE -


# PROMĚNNÉ - aplikace / odkaz
*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}


# Metoda: POST
  #Účel: Slouží pro přihlášení uživatele do aplikace

# Vytvořené testy:

*** Test Cases ***
Registrace na kurz platné udaje spravne
    Debug
    Registrace na kurz     2   Nikola    Schebestiková     nschebestikova@data.cz   605315082   fyz     Praha1,Praha    1   Ahoj    true      200


Registrace na kurz prazdne udaje
        Debug
        Registrace na kurz     ${EMPTY}    ${EMPTY}    ${EMPTY}     ${EMPTY}    ${EMPTY}   ${EMPTY}    ${EMPTY}   ${EMPTY}    ${EMPTY}   ${EMPTY}   400
        #má to vracet 400 a přesto mi to neprochází ???

Registrace na kurz chybne formaty
    Debug
    Registrace na kurz    1   4nika4    Schebestiková     data.cz   66666   fyz     Praha1,Praha    OK   Ahoj    true       500

Registrace na kurz chybný prázdný email
    Debug
    Registrace na kurz      2   Nikola    Schebestiková     ${EMPTY}   605315082   fyz     Praha 1,Praha    1   Nic       true     500

Registrace na kurz prázdný telefon
    Debug
    Registrace na kurz  1   Nikola    Šebestová     sebestova@data.cz   ${EMPTY}   fyz     Praha 1,Praha    1   Ahoj    true      500


#registrace na kurz web - klíčová slova - argumenty do JSON a vytvoření těla JSONu
*** Keywords ***

Registrace na kurz
    [Arguments]      ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${responce_code}


# vytoření JSON zprávy
  # ${json}=  catenate  {"targetid":"","kurz":"2","name":"Jan","surname":"Tester","email":"jantester@email.cz","phone":"7606505202","person":"fyz","address":"Udolni 20, Praha","ico":"27232433","count":"1","comment":"nic","souhlas":true}

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
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

     Log                Převod na UTF-8: ${json}   level=INFO
     Log                Převod na UTF-8: ${json}   level=DEBUG   formatter=repr
     # dávalo by mi smysl dávat ty LOG - DEBUGLOGY SEMKA ?

    # vytoření hlavičky (header) zprávy
   &{header}=   Create Dictionary   Content-Type=application/json
   Log To Console    ${header}   level=DEBUG   formatter=repr
   Log    ${header}  level=DEBUG
   # dávalo by mi smysl dávat ty LOG - DEBUGLOGY SEMKA ?

#POST Request
#    ${resp} =           POST  ${urlapp}  data=${json}  expected_status=Anything
     ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=${responce_code}
 #    Je to takto tedy ok ????
    Log                 Response: ${resp}  level=debug  formatter=repr
#    Log                 Response: ${resp}  level=info   formatter=repr
# využít tyto debugy, logy zde... ?
    Log    Response: ${resp}        level=TRACE     formatter=repr


# vytvoření spojení (session)
#    CreateSession       apilogin            ${url}
#    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=${responce_code}
    Log	                Responce: @{resp}

# Vyhodnocení
   #vyhodnocení status kódu
    Status should be    ${responce_code}
    #nebo
    Should Be Equal As Strings	    ${resp.status_code}     ${responce_code}

    Log    ${responce_code}     leve=INFO

