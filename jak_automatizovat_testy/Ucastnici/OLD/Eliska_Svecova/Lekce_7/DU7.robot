*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Library         Browser


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}



*** Test Cases ***

TestLogin +Registrace
    Login    admin    tajneadmin    Chrome 101.0.4951.67    200
    #"username":"admin","password":"tajneadmin","useragent":"Chrome 101.0.4951.67"

TestLogin -Registrace
    Login   novak   tohlenenidobreheslo   ${EMPTY}  403      #403 špatné heslo
    #"username":"novak","password":"tohlenenidobreheslo"




*** Keywords ***


Login
    [Arguments]        ${jmeno}  ${heslo}  ${prohlizec}  ${status_code}
    #{"username":"admin","password":"tajneadmin","useragent":"Chrome 101.0.4951.67"}
    # vytvoření těla (body) zprávy
    ${json}=           catenate  {"username":"${jmeno}","password":"${heslo}","useragent":"${prohlizec}"}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes  ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=         Create Dictionary                  Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}=            Post  ${urlapp}     data=${json_utf8}   headers=${header}   expected_status=Anything

    #vyhodnocení status kódu
    Should Contain    ${status_code}    403

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain      ${json}  ${jmeno}

    Log                  ${resp.json()}
