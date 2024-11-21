"""
Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

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
# zde budou testy např: Registrace na kurz fyzicka osoba
    Registrace na kurz       1    Karel    Novák   jan.novak@abc.cz   608123123  fyz   Habrova,Třinec,73961   70272017    5     ahojkoment    ano    200

Registrace na kurz PO
    Registrace na kurz       2    Karel    Novák   jan.novak@abc.cz   608123123  pra   Habrova,Třinec,73961   70272017    5     ahojkoment    ano    200

Registrace na kurz hačky čarky
    Registrace na kurz       1    Karelšššš    Novákččč   jan.novak@abc.cz   608123123  fyz   Habrova,Třinec,73961   70272017    5     ahojkoment    ano    200

Registrace na kurz nevyplněný komentář EMPTY
    Registrace na kurz       2    Karel    Novák   jan.novak@abc.cz   608123123  fyz   Habrova,Třinec,73961   70272017    5     ${EMPTY}      ano    500

Registrace na kurz chybná emailovka
    Registrace na kurz       1    Karel    Novák   jan.novak@   608123123  fyz   Habrova,Třinec,73961   70272017    5     ahojkoment    ano    500
  # kurz  name  surname  email  phone  person  address  ico  count  comment  souhlas


*** Keywords ***
# Klíčové slovo pro registraci na kurz z pohledu funčnosti, tedy uživatele
Registrace na kurz
#Vymyslete název klíčového slova
    [Arguments]        ${kurz}   ${name}   ${surname}   ${email}   ${phone}    ${person}   ${adress}   ${ico}     ${count}   ${coment}    ${souhlas}    ${error_resp}
    # vytvoření těla (body) zprávy
    ${json} =    catenate    {"targetid":"","kurz":"${kurz}" ,"name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${adress}","ico":"${ico}","count":"${count}","comment":"${coment}","souhlas":"${souhlas}"}
    #převedení do UTF-8
    ${json_utf8} =   Encode String To Bytes   ${json}    UTF-8
    #vytoření hlavičky (header) zprávy
    ${header} =   catenate    Content-Type=application/json
    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =        POST  ${urlapp}  data=${json}   expected_status=${error_resp}
    Log                    Responce: @{resp}
    #vyhodnocení status kódu
    Status Should Be    ${error_resp}
    Dictionary Should Contain Item ${resp.json()}          response    ${error_resp}

    #vyhodnocení JSONu klíč responce
    Should Contain      ${resp.json()}[responce]            ${error_resp}






