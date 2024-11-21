
*** Settings ***
Library	    RequestsLibrary
Library     String
Library     Collections

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
    Registrace na kurz     2   Nikola    Schebestiková     nschebestikova@data.cz   605315082   fyz     Praha1,Praha    1   Ahoj    true      200


Registrace na kurz prazdne udaje
        Registrace na kurz     ${EMPTY}    ${EMPTY}    ${EMPTY}     ${EMPTY}    ${EMPTY}   ${EMPTY}    ${EMPTY}   ${EMPTY}    ${EMPTY}   ${EMPTY}   400
        #má to vracet 400 a přesto mi to neprochází ???

Registrace na kurz chybne formaty
    Registrace na kurz    1   4nika4    Schebestiková     data.cz   66666   fyz     Praha1,Praha    OK   Ahoj    true       500

Registrace na kurz chybný prázdný email
    Registrace na kurz      2   Nikola    Schebestiková     ${EMPTY}   605315082   fyz     Praha 1,Praha    1   Nic       true     500

Registrace na kurz prázdný telefon
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

    #   # vytoření hlavičky (header) zprávy
   &{header}=   Create Dictionary   Content-Type=application/json

#POST Request
#    ${resp} =           POST  ${urlapp}  data=${json}  expected_status=Anything
     ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=${responce_code}
 #    Je to takto tedy ok ????
    Log                 Response: ${resp}

#    Status Should Be    ${resp}


# vytvoření spojení (session)
#    CreateSession       apilogin            ${url}
#    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=${responce_code}
    Log	                Responce: @{resp}

# Vyhodnocení
   #vyhodnocení status kódu
    Status should be    ${responce_code}
    #nebo
    Should Be Equal As Strings	    ${resp.status_code}     ${responce_code}

    #vyhodnocení JSONu klíč response
#    Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}
    #nebo

#    Should Contain      ${resp.json()}[response]            ${responce_code}
       #PŘIDAT PODMÍNKU IF ELSE - MOŽNOST ŘEŠIT TAKTO


#   [Return]  200




# PŘÍKLADY: Formát hlavičky (header):
            #Content-Type=application/json
            #
            #Příklad pozitivního dotazu
            #{"username":"admin","password":"tajneadmin","useragent":"Chrome 101.0.4951.67"}
            #
            #
            #
            #Příklad odpovědi na pozitivní dozat
            #{
            #    "response": "200",
            #    "reason": "correct",
            #    "agent": {
            #        "browser": "Chrome 101.0.4951.67",
            #        "version": ""
            #    }
            #}

            #Příklad chybného dotazu
            #{"username":"novak","password":"tohlenenidobreheslo"}

            #Příklad odpověď na chybný dotaz
            #{
            #    "response": "403",
            #    "reason": "spatne heslo",
            #    "agent": []
            #}
