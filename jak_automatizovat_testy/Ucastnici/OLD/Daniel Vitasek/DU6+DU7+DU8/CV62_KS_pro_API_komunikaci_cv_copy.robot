
*** Settings ***
Library     Collections
Library     RequestsLibrary
Library     String
Library     Browser

Resource    ../Projekt/TestData.robot


*** Variables ***
${json_registrace_specialni_znaky}      {"targetid":"","kurz":"1","name":"Honzík","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123125","person":"prá","address":"Brno, Ostravská 123","ičo":"234563234","count":"1","comment":null,"souhlas":true}


*** Test Cases ***

Registrace ok
    API Comunication  ${json_cv62_registrace_ok}   200

registrace neexistujici kurz - neg
    API Comunication  ${json_cv62_registrace neexistujici kurz - neg}   500

registrace bez volby kurzu
    API Comunication  ${json_cv62_registrace bez volby kurzu}   200

registrace bez volby kurzu - neg
    API Comunication  ${json_cv62_registrace bez volby kurzu - neg}   500

registrace moc dlouhe cislo
    API Comunication  ${json_cv62_registrace moc dlouhe cislo}   500

registrace moc kratke cislo
    API Comunication  ${json_cv62_registrace moc kratke cislo}   500

registrace moc kratke cislo - neg
    API Comunication  ${json_cv62_registrace moc kratke cislo - neg}   500

registrace bez vyplneho jmena
    API Comunication  ${json_cv62_registrace bez vyplneho jmena}   500

registrace nesouhlas
    API Comunication  ${json_cv62_registrace nesouhlas}   200

registrace bez povinnych - nevyplnene
    API Comunication  ${json_cv62_registrace bez povinnych - nevyplnene}   500

registrace bez povinnych - bez parametru
    API Comunication  ${json_cv62_registrace bez povinnych - bez parametru}   500

registrace bez nepovinnych
    API Comunication  ${json_cv62_registrace bez nepovinnych}   200

registrace JSON chyby - chybejci , : ""
    API Comunication  ${json_cv62_registrace JSON chyby - chybejci , : ""}   500

registrace JSON chyby - chybne nazvy parametru
    API Comunication  ${json_cv62_registrace JSON chyby - chybne nazvy parametru}  500

registrace specialni znaky
    API Comunication  ${json_registrace_specialni_znaky}    500


login do aplikace123
    API Property    ${json_cv62_login_ok}    200

login do aplikace - prazdne hodnoty
    API Property    ${json_cv62_login prazdne hodnoty}    403

login do aplikace - spatne heslo
    API Property    ${json_cv62_login spatne heslo}    403

login do aplikace - spatne parametry
    API Property    ${json_cv62_login spatne parametry}    403

login do aplikace - chybejici parametry
    API Property    ${json_cv62_login chybejici parametry}    403


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    Log    ${json}    level=DEBUG
    Log    ${error_resp}    level=DEBUG

    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =          POST  ${URLAPP_REG}  data=${json}    expected_status=${error_resp}

    Log    ${resp}    level=TRACE

API Property
    [Arguments]       ${json}     ${resp_code}

    Log    Debug: JSON Data: ${json}
    Log    Debug: Expected Response Code: ${resp_code}

    &{header}=       Create Dictionary  Content-Type=application/json
    CreateSession    apilogin           ${API_URL}
    ${resp} =        POST On Session    apilogin    ${APP_LOG}    data=${json}       headers=${header}
    Log     Response: @{resp}
    Log     Trace: Response: ${resp.text}
    Log     Debug: Response Code: ${resp.status_code}

    Should Be Equal          ${resp.json()}[response]    ${resp_code}
    Log                      ${resp.json()}[response] se rovna ${resp_code}