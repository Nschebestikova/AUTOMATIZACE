*** Settings ***
Library  RequestsLibrary
Library  String

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      /login_app/userauth.php
${urlapp}   ${url}${app}


*** Test Cases ***
Uspesne prihlaseni
    Login  admin  tajneadmin  Chrome 101.0.4951.67  200

Neuspesne prihlaseni
    Login   netocna  fakeheslo  Chrome 101.0.4951.67   403

*** Keywords ***
Login
    [Arguments]          ${username}  ${password}  ${useragent}  ${response_code}
    ${json}=       Set Variable  {"username":"${username}","password":"${password}","useragent":"${useragent}"}
    ${resp} =          POST  ${urlapp}  data=${json}
    Should Be Equal    ${resp.json()}[response]    ${response_code}