*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      /login_app/userauth.php
${urlapp}   ${url}${app}



*** Test Cases ***
Spravne prihlaseni spravne udaje
    PRIHLASENI API KURZ    novak        tajnenovak       Chrome 123.0.6312.107      200


Spatne prihlaseni spatne heslo
    PRIHLASENI API KURZ     novak       badpassword     Chrome 123.0.6312.107   403

Spatne prihlaseni spatny login name
    PRIHLASENI API KURZ     badlogin    tajnenovak   Chrome 123.0.6312.107   403

Spatne prihlaseni prazdne hodnoty
    PRIHLASENI API KURZ     ""      ${EMPTY}   Chrome 123.0.6312.107     403


# poznámka/dotaz - nenašla jsem možnost, jak se přihlásit, že vytvořím své údaje = hledala jsem v původní registraci - chtěla jsem si tam dát jiné hodnoty a více pohrát...

*** Keywords ***
PRIHLASENI API KURZ
    [Arguments]         ${name}     ${password}    ${useragent}     ${response_code}

    ${json} =   Catenate    {"username":"${name}",
    ...     "password":"${password}",
    ...     "useragent":"${useragent}"}

    ${resp} =      POST     ${urlapp}     data=${json}      expected_status=Anything

    Log            ${resp.json()}

    Should Be Equal    ${resp.json()}[response]    ${response_code}

    Log To Console    ${resp.json()}[response]




