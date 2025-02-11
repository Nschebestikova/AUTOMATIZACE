"""
NOVA APP API
Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests
"""

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

# získá CSRF token před samotnou sadou testů
Suite Setup     Start


*** Variables ***
${url}		        http://testovani.kitner.cz
${urlCSRF}=         ${url}/sanctum/csrf-cookie
${urlLOGIN}         ${url}/login
${urlLOGOUT}        ${url}/logout
${csrf_token}       token nebyl ziskan
${laravel_session}  token nebyl ziskan



*** Test Cases ***
API Správné přihlášení uživatele
    API_Login  lector@lector.com   lector@lector.com  204
    API_Logout

API Přihlášení chybné heslo uživatele
    API_Login  lector@lector.com   blbost  403


*** Keywords ***

Start
    Get CSRF Token Start


Get CSRF Token From Response and Set Token Gloal Variable
    [Arguments]       ${response}
    #vytáhní z headeru XSRF-TOKEN a ulož do ${csrf_token}
    # Získání hodnoty Set-Cookie a extrahování CSRF tokenu
    ${cookies}=       Get From Dictionary    ${response.headers}    Set-Cookie

    ${csrf_token}=    Get Substring    ${cookies}    ${cookies.find('XSRF-TOKEN=')}    ${cookies.find(';')}
    ${csrf_token}=    Replace String    ${csrf_token}    XSRF-TOKEN=    ${EMPTY}
    # uloží do globální proměnné
    Set Global Variable     ${csrf_token}

    ${laravel_session}=    Get Substring    ${cookies}    ${cookies.find('laravel_session=')}    ${cookies.find(';')}
    ${laravel_session}=    Replace String    ${laravel_session}    laravel_session=    ${EMPTY}
    # uloží do globální proměnné
    Set Global Variable     ${laravel_session}




    # a také jej vrati, jak výstup z klíčového slova
    [Return]    ${csrf_token}


Get CSRF Token Start

    ${response} =       GET  ${urlCSRF}  expected_status=204
    Log                 Response: @{response}

    Get CSRF Token From Response and Set Token Gloal Variable   ${response}


API_Login
    [Arguments]    ${email}  ${password}  ${response_code}

    # vytvoření těla (body) zprávy
    ${json}=     Catenate      {"email":"${email}","password":"${password}"}

    # převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    # vytvoření hlavičky (header) zprávy s CSRF tokenem
#    &{header}=          Create Dictionary   Content-Type=application/json  X-CSRF-Token=${csrf_token}
    &{header}=          Create Dictionary   Accept=application/json  Content-Type=application/json  X-XSRF-TOKEN=${csrf_token}  Cookie=X-XSRF-TOKEN=${csrf_token} laravel_session=${laravel_session}



    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlLOGIN}   data=${json_utf8}  headers=${header}  expected_status=Anything
    Log                 Response: @{resp}

    Get CSRF Token From Response and Set Token Gloal Variable   ${resp}

    # vyhodnocení status kódu
    Status should be    ${response_code}
    # nebo
    Should Be Equal As Strings     ${resp.status_code}     ${response_code}

    # Logování odpovědi
    Log To Console    ${resp.text}
    Log To Console    ----
    Log To Console    ${resp.url}



API_Logout

    # vytvoření hlavičky (header) zprávy s CSRF tokenem
    &{header}=          Create Dictionary   Content-Type=application/json  X-XSRF-TOKEN=${csrf_token}

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlLOGOUT}   headers=${header}  expected_status=Anything
    Log                 Response: @{resp}

    Get CSRF Token From Response and Set Token Gloal Variable   ${resp}

    # vyhodnocení status kódu
    Status should be    200
    # nebo
    Should Be Equal As Strings     ${resp.status_code}     200

    # Logování odpovědi
    Log To Console    ${resp.text}
    Log To Console    ----
    Log To Console    ${resp.url}





























