
*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

# cv61
Prvni API test
      ${response}=      GET  https://www.google.com
      Status Should Be  200
      Log to Console    ${response}


Quick Get A JSON Body Test 1
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
      Should Be Equal As Strings    1  ${response.json()}[id]

      Log To Console  ${response.ok}
      Log To Console  ${response.status_code}
      Log To Console  ${response.headers}
      Log To Console  ${response.reason}
      Log To Console  ${response.json()}[id]


API Response andreashop
    ${response}=                GET    https://www.andreashop.sk/        params=search=mobil

Quick Get Request Test
    ${response}=                GET  https://www.google.com

Quick Get Request With Parameters Test
    ${response}=                GET  https://www.google.com/search  params=query=ciao  expected_status=200

Quick Get A JSON Body Test 2
    ${response}=                GET  https://jsonplaceholder.typicode.com/posts/5
    Should Be Equal As Strings  blabla  ${response.json()}[title]


# cv62
registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}


    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =          POST  ${urlapp}  data=${json}







