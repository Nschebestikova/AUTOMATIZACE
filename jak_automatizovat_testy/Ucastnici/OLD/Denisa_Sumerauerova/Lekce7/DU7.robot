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
    Registrace na kurz  admin  heslo  Chrome 101.0.4951.67  200

Registrace - negativní
    Registrace na kurz  admin  spatneheslo  Chrome 101.0.4951.67  500

*** Keywords ***
Registrace na kurz
     [Arguments]    ${jmeno}  ${heslo}  ${browser}  ${status_code}

    #telo zpravy
     ${json}=      catenate  catenate  {"username":"${jmeno}","password":"${heslo}","useragent":"${browser}"}

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    #hlavicka zpravy
    &{header}=          Create Dictionary   Content-Type=application/json


    #odeslani zpravy a ulozeni odpovedi
    ${resp}=   Post   ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=Anything

    #vyhodnoceni
    Status Should Be    ${status_code}  #vyhodnoceni kodu

    Should Contain    ${json}  ${jmeno}  #vyhodnoceni hodnoty "jmeno"