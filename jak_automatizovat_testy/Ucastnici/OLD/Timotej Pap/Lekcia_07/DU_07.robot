*** Settings ***
Library         RequestsLibrary
Library         String
Library         Collections

*** Variables ***
${URL}          http://testovani.kitner.cz
${APP}          /login_app/userauth.php
${URLAPP}       ${URL}${APP}


*** Test Cases ***
Login Fyzicka osoba
    Login na web    admin    tajneadmin    Chrome    117.0.5938.150    200

Login prazdne meno
    Login na web    kral    tajneadmin    Chrome    117.0.5938.150    403

Login zle heslo
    Login na web    admin    zleheslo    Chrome    117.0.5938.150    403


*** Keywords ***
Login na web
    [Arguments]     ${meno}     ${heslo}   ${useragent}  ${verzia}     ${resp_code}
    ${json} =       Catenate        {"username":"${meno}","password":"${heslo}","useragent":"${useragent}","version":"${verzia}"}
    ${json_utf8} =                  Encode String To Bytes  ${json}             UTF-8
    &{header} =     Create Dictionary    Content-Type=application/json
    ${resp} =       POST            ${URLAPP}       data=${json_utf8}   headers=${header}  expected_status=${resp_code}
    Log                             ${resp.json()}
    Log             skuska  TRACE
    Log             skuska2 DEBUG
    Status Should Be                200
    Dictionary Should Contain Item  ${resp.json()}  response    ${resp_code}