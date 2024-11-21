*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}


*** Test Cases ***

Login spravny
    Login   admin   tajneadmin   Chrome 118.0.5993.70   200
Login spatne heslo
    Login   admin   tajne   Chrome 118.0.5993.70   403
Login prazdne heslo
    Login   admin   ${EMPTY}   Chrome 118.0.5993.70   403
Login heslo velkymi pismeny
    Login   admin   TAJNDEADMIN   Chrome 118.0.5993.70   403
Login spatne jmeno
    Login   adminek   tajneadmin   Chrome 118.0.5993.70   403
Login prazdne jmeno
    Login   ${EMPTY}   tajneadmin   Chrome 118.0.5993.70   403
Login jmeno velkymi pismeny
    Login   ADMIN   tajneadmin   Chrome 118.0.5993.70   200


*** Keywords ***


Login
    [Arguments]    ${username}  ${password}  ${useragent}   ${response_code}

    ${json}=     Catenate      {"username":"${username}","password":"${password}","useragent":"${useragent}"}

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    &{header}=          Create Dictionary   Content-Type=application/json

    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything

    Log	                Response: @{resp}

    Status should be    ${response_code}

    Should Contain      ${resp.json()}[response]            ${response_code}