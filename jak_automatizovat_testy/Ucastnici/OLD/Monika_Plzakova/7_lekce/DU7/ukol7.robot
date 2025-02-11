*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Library         Dialogs

Resource    TestDataDU7.robot
Resource    ConfigDU7.robot

*** Test Cases ***
Prihlaseni_spravne_udaje
    Prihlaseni    ${uzivatel}       ${heslo}      ${prohlizec}    ${response_OK}   correct

Prihlaseni_spatne_heslo
    Prihlaseni    ${uzivatel}       hesloheslo    ${prohlizec}    ${response_OK}   spatne heslo
    
Prihlaseni_spatne_jmeno
    Prihlaseni    mirek             ${heslo}      ${prohlizec}    ${response_OK}   neexistujici uzivatel

Prihlaseni_nezadani_hesla
    Prihlaseni    ${uzivatel}       ${EMPTY}      ${prohlizec}    ${response_OK}   spatne heslo

Prihlaseni_nezadani_jmena
    Prihlaseni    ${EMPTY}          ${heslo}      ${prohlizec}    ${response_OK}   chybi prihlasovaci jmeno

*** Keywords ***
Prihlaseni
    [Arguments]       ${username}     ${password}    ${agent}    ${response_code}    ${odpoved}

    ${json}=   Catenate    {"targetid":"",
    ...  "username":"${username}",
    ...  "password":"${password}",
    ...  "useragent":"${agent}"}

    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    &{header}=          Create Dictionary   Content-Type=application/json
    ${response}=        POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything

    Should Be Equal    ${odpoved}    ${response.json()}[reason]
    Log	               Response: @{response}
    Log                ${response.json()}[reason]

    Should Be Equal As Strings	    ${response.status_code}     ${response_code}