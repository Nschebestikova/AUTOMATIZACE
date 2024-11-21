*** Settings ***
Metadata    Author    Patrik Sova
Metadata    Purpose   API Login
Metadata    Created   24.1.2024


Library	        Collections
Library	        RequestsLibrary
Library         String


Resource    TestDataDU7.robot
Resource    ConfigDU7.robot

*** Test Cases ***
Prihlaseni_vse_ok_admin
    Prihlaseni    ${uzivatel1}       ${heslo1}      ${chrome}    ${response_200}

Prihlaseni_spatne_heslo_admin
    Prihlaseni    ${uzivatel1}       ${spatne_heslo}    ${chrome}    ${response_403}

Prihlaseni_spatne_jmeno_admin
    Prihlaseni    ${spatny_uzivatel}             ${heslo1}      ${chrome}   ${response_403}

Prihlaseni_nezadano_hesla_admin
    Prihlaseni    ${uzivatel1}       ${empty}      ${chrome}    ${response_403}

Prihlaseni_nezadano_jmena_admin
    Prihlaseni    ${empty}          ${heslo1}      ${chrome}    ${response_403}

Prihlaseni_vse_ok_novak
    Prihlaseni    ${uzivatel2}       ${heslo2}      ${chrome}    ${response_200}

Prihlaseni_spatne_heslo_novak
    Prihlaseni    ${uzivatel2}       ${spatne_heslo}    ${chrome}    ${response_403}

Prihlaseni_spatne_jmeno_novak
    Prihlaseni    ${spatny_uzivatel}         ${heslo2}      ${chrome}    ${response_403}

Prihlaseni_nezadano_hesla_novak
    Prihlaseni    ${uzivatel2}       ${empty}      ${chrome}   ${response_403}

Prihlaseni_nezadano_jmena_novak
    Prihlaseni    ${empty}          ${heslo2}      ${chrome}    ${response_403}
*** Keywords ***
Prihlaseni
    [Arguments]       ${username}     ${password}   ${agent}      ${response_any}

     ${json}=   Catenate    {"targetid":"",
    ...  "username":"${username}",
    ...  "password":"${password}",
    ...  "useragent":"${agent}"}


    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    &{header}=          Create Dictionary   Content-Type=application/json
    ${response}=        POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything

    ${response_body}=    Set Variable    ${response.json()}    # Extrahování JSON obsahu z odpovědi
    ${response_code}=    Set Variable    ${response_body['response']}    # Extrahování hodnoty 'response' z JSON
    Should Be Equal As Numbers    ${response_code}      ${response_any}
    Log	               Response: @{response}
    Log                ${response.json()}[reason]

