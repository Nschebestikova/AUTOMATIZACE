#testování aplikace TestLogin - http://testovani.kitner.cz/login_app/

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Library         Browser

*** Variables ***
${url}		        http://testovani.kitner.cz
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}

*** Test Cases ***
Login správné přihlašovací údaje - pozitivní
    Login  admin  tajneadmin  200
    Login  novak  tajnenovak  200

Login username 20 znaků - negativní
    Login  aaaaaaaaaabbbbbbbbbb  spatneheslo  403

Login username 21 znaků - negativní
    Login  aaaaaaaaaabbbbbbbbbbc  spatneheslo  403

Login heslo 20 znaků - negativní
    Login  spatnejmeno  aaaaaaaaaabbbbbbbbbb  403

Login heslo 200 znaků - negativní
    Login  spatnejmeno  aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjjkkkkkkkkkkllllllllllmmmmmmmmmmnnnnnnnnnnooooooooooppppppppppqqqqqqqqqqrrrrrrrrrrsssssssssstttttttttt  403

Login správné jméno, prázdné heslo - negativní
    Login  admin  ${empty}  403

Login prázdné jméno, správné heslo - negativní
    Login  ${empty}  tajnenovak  403

Login prázdné jméno, prázdné heslo - negativní
    Login  ${empty}  ${empty}  403

Login správné jméno, špatné heslo - negativní
    Login  admin  spatneheslo  403

Login správné jméno, špatné heslo spec. znaky - negativní
    Login  admin  @đĐ[  403

Login speciální znaky jméno, špatné heslo spec. znaky - negativní
    Login  @đĐ[  @đĐ[  403

Login háčky čárky jméno, špatné heslo spec. znaky - negativní
    Login  ščřřžžýá  ščřřžžýá  403

Login chybný JSON formát - negativní
    Login Incorrect JSON format  admin  tajneadmin  400

*** Keywords ***
Login
    [Arguments]       ${username}  ${password}  ${resp_code}
    ${json} =  Catenate  {"username":"${username}","password":"${password}","useragent":"Chrome"}
    ${json_utf8} =   Encode String To Bytes   ${json}    UTF-8
    &{header} =  Create Dictionary   Content-Type=application/json
    ${resp} =    POST  ${urlapp}  data=${json_utf8}  headers=${header}  expected_status=Anything
    Log   ${resp.json()}
#    Status Should Be   ${resp_code}
    Should Contain     ${resp.json()}[response]  ${resp_code}

Login Incorrect JSON format
    [Arguments]       ${username}  ${password}  ${resp_code}
    ${json} =  Catenate  {"${username}",${password}, "Chrome"}
    ${json_utf8} =   Encode String To Bytes   ${json}    UTF-8
    &{header} =  Create Dictionary   Content-Type=application/json
    ${resp} =    POST  ${urlapp}  data=${json_utf8}  headers=${header}  expected_status=Anything
#    Log   ${resp.json()}
    Status Should Be   ${resp_code}
#    Should Contain     ${resp.json()}[response]  ${resp_code}
