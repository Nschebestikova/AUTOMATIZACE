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
#Resource        Data_and_Config/TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

#Přidat testy, třeba s prázdným komentářem


*** Keywords ***


Registrace na kurz
    [Arguments]        ${kurz}  ${meno}  ${priezvisko}  ${email}  ${telefonne_cislo}  ${typ_osoby}  ${adresa_ico}  ${pocet}  ${comment}  ${suhlas}  ${status_code}

    # vytvoření těla (body) zprávy
    ${json}=           catenate  {"targetid":"","kurz":"${kurz}","name":"${meno}","surname":"${priezvisko}","email":"${email}","phone":"${telefonne_cislo}","person":"${typ_osoby}","address":"${adresa_ico}","ico":"${adresa_ico}","count":"${pocet}","comment":"${comment}","souhlas":${suhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes  ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary                  Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    #${resp} =           POST  #??? DOPLNIT ???#
    #Log	                Responce: @{resp}

    #vytvoření spojení (session)
    #CreateSession       apilogin            ${url}

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}=   Post   ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=Anything

    #vyhodnocení status kódu
    #??? DOPLNIT ???#
    Status Should Be    ${status_code}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain    ${json}  ${telefonne_cislo}


