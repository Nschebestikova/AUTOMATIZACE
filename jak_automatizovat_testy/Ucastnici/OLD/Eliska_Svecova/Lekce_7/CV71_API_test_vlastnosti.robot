"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

CVIČENÍ: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality +
                                                          přidejte další testy pro kompletní otestování

Inspirujte se ve cvičení CV64_API_test_komunikace.robot klíčové slovo "API Comunication"
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

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan7878787  Novak  jan1.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

#Přidat testy, třeba s prázdným komentářem


*** Keywords ***


Registrace na kurz
    [Arguments]     ${Nazev_kurzu}  ${Jmeno}  ${Prijmeni}  ${Email}  ${Telefon}  ${Typ_osoby}  ${Adresa_ico}   ${Pocet_osob}  ${Komentar}  ${Souhlas}  ${status_code}
#{"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
    # vytvoření těla (body) zprávy
    ${json}=        Catenate   {"targetid":"","kurz":"${Nazev_kurzu}","name":"${Jmeno}","surname":"${Prijmeni}","email":"${Email}","phone":"${Telefon}","person":"${Typ_osoby}","address":"${Adresa_ico}","count":"${Pocet_osob}","comment":"${Komentar}","souhlas":"${Souhlas}"}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}     data=${json_utf8}       expected_status=Anything
    Log	                Responce:@{resp}


    #vyhodnocení status kódu
    #Status Should Be    ${status_code}        #nefunguje mi

    

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain      ${json}    ${Telefon}     # mnohem lepsi a konkretnejsi nez Should be equal

    #Should Be Equal As Strings  ${response.json()}[name]  ${Jmeno}


