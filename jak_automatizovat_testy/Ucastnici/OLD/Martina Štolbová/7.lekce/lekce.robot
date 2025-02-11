*** Settings ***
Library     RequestsLibrary
Library     String
*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

*** Test Cases ***
Registrace uzivatele fyz
    Registrace na kurz   2  Petr  Bajza  bajza@seznam.cz  777654659  fyz  Pivovarská 988, 33701, Město  12  komentář  false   200


Registrace uzivatele prav
    Registrace na kurz   1  Eliška  Přemyslovna  eliska@seznam.cz  777654654  pra  25596641  1  komentář  true     200



*** Keywords ***
Registrace na kurz
    [Arguments]     ${kurz}     ${name}     ${surname}      ${email}    ${phone}    ${person}   ${ico_address}  ${count}    ${comment}  ${souhlas}  ${response_code}


    IF      "${person}" == "pra"
            ${json} =    Set Variable      {"targetid":"","kurz":"${kurz}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"","ico":"${ico_address}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    ELSE
            ${json} =   Set Variable        {"targetid":"","kurz":"${kurz}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${ico_address}","ico":"","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    END
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8
    ${header} =     Create Dictionary   Content-Type=application/json
    ${resp} =   POST    ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=anything

    Status Should Be    ${response_code}


