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
    Registrace na kurz  2   Nikola  Schebestiková   fyz     Adresa 1 Praha     nschebestikova@seznam.cz    505404303   1   Ahoj     true   200

Registrace na kurz spatne udaje
    Registrace na kurz

Registrace na kurz prazdne udaje
    Registrace na kurz
Registrace na kurz chybne formaty
    Registrace na kurz

Registrace na kurz chybný prázdný email
    Registrace na kurz

Registrace na kurz prázdný telefon
    Registrace na kurz

#registrace na kurz web - klíčová slova - argumenty do JSON a vytvoření těla JSONu
*** Keywords ***

Registrace na kurz
    [Arguments]      ${kurz}    ${jmeno}    ${prijmeni}     ${typ_osoba}   ${adresa_ico}    ${email}    ${telefon}    ${pocet_osob}   ${comment}   ${souhlas}      ${response_code}

# vytoření JSON zprávy
  # ${json}=  catenate  {"targetid":"","kurz":"2","name":"Jan","surname":"Tester","email":"jantester@email.cz","phone":"7606505202","person":"fyz","address":"Udolni 20, Praha","ico":"27232433","count":"1","comment":"nic","souhlas":true}

    ${json}=     Catenate      {"targetid":"","kurz":"${kurz}",
    ...  "name":"${jmeno}",
    ...  "surname":"${prijmeni}",
    ...  "email":"${email}",
    ...  "person":"${typ_osoba}",
    ...  "address":"$${adresa_ico}"
    ...  "phone":"${telefon}",
    ...  "ico":"${addresa_ico}",
    ...  "count":"${pocet_osob}",
    ...  "comment":"${comment},
    ...  souhlas":${souhlas}}


   #převedení do UTF-8
    #${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

#POST Request
    ${resp} =           POST  ${urlapp}  data=${json}  expected_status=Anything

    Log                 Responce: ${resp}

#    Status Should Be    ${resp}

#   # vytoření hlavičky (header) zprávy
   &{header}=   Create Dictionary   Content-Type=application/json
#
#   # vytvoření spojení (session)
#    CreateSession       apilogin            ${url}
#   # odeslání zprávy a uložení odpovědi do ${resp}
#   ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}


# Vyhodnocení
    Status Should Be    ${response_code}
    Should Be Equal    ${resp.JSON()}[response ]    200

#   [Return]  200

# PŘÍKLADY: Formát hlavičky (header):
            #Content-Type=application/json
            #
            #
            #Příklady jsou na další stránce!!!
            #
            #
            #
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
            #
            #
            #
            #
            #
            #Příklad chybného dotazu
            #{"username":"novak","password":"tohlenenidobreheslo"}
            #
            #
            #
            #
            #
            #
            #Příklad odpověď na chybný dotaz
            #{
            #    "response": "403",
            #    "reason": "spatne heslo",
            #    "agent": []
            #}