*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***
Pos_Registrace - fyzicka osoba
    Registrace na kurz  2  Jan787878  Kroupa  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

Pos_Registrace - pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Pos_Registrace - háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

Pos_Registrace - fyzicka osoba - prázdný komentář
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  ${EMPTY}  false  200

Neg_Registrace - pravnicka osoba - nevyplněný název kurzu
    Registrace na kurz      ${EMPTY}  Honza  Novak  jan.novak@abc.cz  777123123  pra  27232433  2  dekuji  false  500

Neg_Registrace - pravnicka osoba - nevyplněné jméno
    Registrace na kurz  2  ${EMPTY}  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  500

Neg_Registrace - fyzicka osoba - nevyplněné příjmení
    Registrace na kurz  1  Jan787878  ${EMPTY}  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  500

Neg_Registrace - pravnicka osoba - nevyplněný email
    Registrace na kurz  3  Jan787878  Novak  ${EMPTY}  777123123  pra  27232433  1  dekuji  false  500

Neg_Registrace - fyzicka osoba - nevyplněný telefon
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  ${EMPTY}  fyz  Udolni 21, Brno  1  komentar  false  500

Neg_Registrace - pravnicka osoba - nevyplněný typ osoby
    Registrace na kurz  1  Honza  Novak  jan.novak@abc.cz  777123123  ${EMPTY}  27232433  1  dekuji  false  500

Neg_Registrace - pravnicka osoba - nevyplněné IČO
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  ${EMPTY}  1  dekuji  false  500

Neg_Registrace - fyzicka osoba - nevyplněna adresa
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  ${EMPTY}  1  komentar  false  500

Neg_Registrace - pravnicka osoba - nevyplněný počet osob
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  ${EMPTY}  ${EMPTY}  true  500

Neg_Registrace - fyzicka osoba - chybny telefon (moc dlouhy)
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  7771231235976985467487698698  fyz  Udolni 21, Brno  1  komentar  false  500

Neg_Registrace - pravnicka osoba - chybny email (tohleneniemail.cz)
    Registrace na kurz  2  Jan787878  Novak  tohleneniemail.cz  777123123  pra  27232433  1  dekuji  false  500

Neg_Registrace - fyzicka osoba - speciální znaky - znak $ v telefonním čísle
    Registrace na kurz  2   Jan787878  Novak  jan.novak@abc.cz  $$$$$$$$$$$  fyz  Udolni 21, Brno  1  komentar  false  500

Neg_Registrace - pravnicka osoba - speciální znaky - znak * v emailu
    Registrace na kurz  2  Jan787878  Novak  jan.novak*abc.cz  777123123  pra  27232433  1  dekuji  false  500

Neg_Registrace - fyzicka osoba - příliš mnoho účastníků
    Registrace na kurz  2  Jan787878  Kroupa  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  10000000000000000000000  komentar  false  500


*** Keywords ***
Registrace na kurz
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${type_of_person}  ${address_ico}  ${amount_of_people}  ${comment}  ${consent}  ${status_code}

    # vytvoření těla (body) zprávy
    ${json}=      catenate  {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${type_of_person}","address":"${address_ico}","ico":"${address_ico}","count":"${amount_of_people}","comment":"${comment}","souhlas":${consent}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=         Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}=   Post   ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=Anything

    #vyhodnocení
    Status Should Be    ${status_code}
    Should Contain      ${json}    ${name}    ${surname}     ${email}    ${phone}    ${type_of_person}    ${address_ico}
    Log                 ${json}

#    oveří, kteří uživatelé byli uspěšně zaregistrováni, jeslti se nemýlim?
#    Should Be Equal     ${resp.json()}[surname]  ${surname}





