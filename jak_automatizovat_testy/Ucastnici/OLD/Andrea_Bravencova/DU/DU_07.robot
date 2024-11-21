*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Library         Browser

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}

*** Test Cases ***

Should Sign in as admin
  Sign in with positive data    admin   tajneadmin   Chrome 101.0.4951.67    200

Should not be Signed in with wrong username
  Sign in with negative data    nobody  tajneadmin   Chrome 101.0.4951.67    403      neexistujici uzivatel

Should not be Signed in with wrong password
  Sign in with negative data     admin  wrongPass    Chrome 101.0.4951.67    200      spatne heslo


*** Keywords ***
Sign in with positive data
    [Arguments]   ${username}    ${password}    ${useragent}   ${response}
    ${json}=     Catenate      {"targetid":"","username":"${username}","password":"${password}","useragent":"${useragent}"}
    &{header}=   Create Dictionary   Accept=application/json  x-requested-with=XMLHttpRequest   charset=utf-8
    ${resp} =    POST  ${urlapp}   data=${json}  headers=${header}  expected_status=Anything
   Log                    Response: @{resp}
   Log                    ${response}
   #vyhodnocení status kódu
   Status should be      ${response}
   Should Contain        ${resp.json()}[response]            ${response}

 Sign in with negative data
    [Arguments]   ${username}  ${password}  ${useragent}   ${response}  ${reason}
    ${json}=     Catenate      {"targetid":"","username":"${username}","password":"${password}","useragent":"${useragent}"}
    &{header}=   Create Dictionary   Accept=application/json  x-requested-with=XMLHttpRequest   charset=utf-8  user-agent=${useragent}
    ${resp} =    POST  ${urlapp}   data=${json}    headers=${header}  expected_status=${response}
    ${reas} =    POST  ${urlapp}     data=${json}  headers=${header}
   Log                    Response: @{resp}
   Log                    ${reason}
   Should Contain                ${resp.json()}[response]            403
   Should Be Equal As Strings    ${reas.json()}[reason]              ${reason}


