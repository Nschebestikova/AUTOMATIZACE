*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections
Library    DebugLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      /login_app/userauth.php
${urlapp}   ${url}${app}



*** Test Cases ***
Spravne prihlaseni spravne udaje
    Debug
    PRIHLASENI API KURZ    novak        tajnenovak       Chrome 123.0.6312.107      200


Spatne prihlaseni spatne heslo
    Debug
    PRIHLASENI API KURZ     novak       badpassword     Chrome 123.0.6312.107   403

Spatne prihlaseni spatny login name
    Debug
    PRIHLASENI API KURZ     badlogin    tajnenovak   Chrome 123.0.6312.107   403

Spatne prihlaseni prazdne hodnoty
    Debug
    PRIHLASENI API KURZ     ""      ${EMPTY}   Chrome 123.0.6312.107     403



*** Keywords ***
PRIHLASENI API KURZ
    [Arguments]         ${name}     ${password}    ${useragent}     ${response_code}

    ${json} =   Catenate    {"username":"${name}",
    ...     "password":"${password}",
    ...     "useragent":"${useragent}"}

    ${resp} =      POST     ${urlapp}     data=${json}      expected_status=Anything
     Log      ${resp}      level=info      formatter=repr
     Log     ${resp}       level=trace     formatter=repr

    Log            ${resp.json()}       level=debug     formatter=repr

    Should Be Equal    ${resp.json()}[response]    ${response_code}


    Log To Console    ${resp.json()}[response]  level=debug     formatter=repr





