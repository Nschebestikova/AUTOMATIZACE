*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}

*** Test Cases ***

Registrace - pozitivní 
    Registrace na kurz  admin  tajneadmin  Chrome 101.0.4951.67  200

Registrace - negativní 
    Registrace na kurz  novak  tohlenenidobreheslo  Chrome 101.0.4951.67  200


*** Keywords ***
Registrace na kurz
    [Arguments]    ${username}  ${password}  ${useragent}  ${status_code}

    # vytvoření těla (body) zprávy
    ${json}=      catenate  {"username":"${username}","password":"${password}","useragent":"${useragent}"}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json


    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}=   Post   ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=Anything

    #vyhodnocení status kódu
    Status Should Be    ${status_code}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain    ${json}  ${password}

    Log                  ${resp.json()}
