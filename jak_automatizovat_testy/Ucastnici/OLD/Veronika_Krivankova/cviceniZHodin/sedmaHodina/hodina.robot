*** Settings ***
Library	  Collections
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

Registrace ok
    Registrace na kurz API      2          John        Doe            fyz         johndoe@email.com      777777777            Udolni 21             1       ${True}      ahoj       200

*** Keywords ***

Registrace na kurz API
    [Arguments]                 ${kurz}    ${jmeno}    ${prijmeni}    ${osoba}    ${email}    ${telefon}    ${Adresa_ICO}    ${pocetOsob}          ${zpracovaniUdaju}        ${komentar}      ${statusCode}
    ${json}=        Catenate    {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${telefon}","person":"${osoba}","address":"${Adresa_ICO}","count":"${pocetOsob}","comment":"${komentar}","souhlas":"${zpracovaniUdaju}"}
    #tady nevím jak dál

    #převedeni do UTF-8
    ${json_utf8} =       Encode String To Bytes    ${json}     UTF-8

    # POST request
    ${resp} =          POST         ${urlapp}      data=${json_utf8}        expected_status=Anything
    Log                Responce: @{resp}

    #vyhodnoceni
   # Status Should Be    ${responce_code}
    Should Be Equal    ${resp.json()}[response]    ${responce_code}


