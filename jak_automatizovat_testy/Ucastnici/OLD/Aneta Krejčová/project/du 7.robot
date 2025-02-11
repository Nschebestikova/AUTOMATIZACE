"""

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}

*** Test Cases ***
prihlašeni pozitivni - vse spravne
    Prihlaseni na kurz     admin  tajneadmin  Chrome 101.0.4951.67  200
prihlaseni pozitivni - velka pismena ve jmenu
    Prihlaseni na kurz   ADMIN  tajneadmin  Chrome 101.0.4951.67  200
prihlaseni negativni - spatne heslo
    Prihlaseni na kurz   admin  spatneheslo  Chrome 101.0.4951.67  403
prihlaseni negativni - heslo s mezerou
    Prihlaseni na kurz   admin  tajne admin  Chrome 101.0.4951.67  403



*** Keywords ***

Prihlaseni na kurz
    [Arguments]       ${username}  ${password}  ${useragent}  ${error_resp}
    ${json} =  Catenate  {"username":"${username}","password":"${password}","useragent":"${useragent}"}
    ${json_utf8} =   Encode String To Bytes   ${json}  UTF-8
    ${resp} =          POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    &{header}=          Create Dictionary   Content-Type=application/json
    Log   ${resp.json()}
    Status Should Be   ${error_resp}
    # vytvoření těla (body) zprávy

    #převedení do UTF-8

    #vytoření hlavičky (header) zprávy

    # odeslání zprávy a uložení odpovědi do ${resp}

    #vyhodnocení status kódu

    #vyhodnocení JSONu klíč response






