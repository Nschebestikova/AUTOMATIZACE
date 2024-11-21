#
#*** Settings ***
#Library  RequestsLibrary
#
#
#*** Variables ***
#${url}      http://testovani.kitner.cz/
#${app}      regkurz/formsave.php
#${urlapp}   ${url}${app}
#
#*** Test Cases ***
#
#Prvni API test
#      ${response}=      GET  https://www.google.com  params=ciao  expected status=200
#      Status Should Be  200
#      Log to Console    ${response}
#
#
#Quick Get A JSON Body Test
#      ${response}=    GET  https://swapi.dev/api/people/1/
#      Should Be Equal As Strings    Luke Skywalker  ${response.json()}[name]
#
#      Log To Console  ${response.ok}
#      Log To Console  ${response.status_code}
#      Log To Console  ${response.headers}
#      Log To Console  ${response.reason}
#      Log To Console  ${response.json()}[name]
#
#
#Cviceni
#      ${response}=    GET  regkurz/formsave.php
#      Should Be Equal As Strings    Luke Skywalker  ${response.json()}[name]
#
#      Log To Console  ${response.ok}
#      Log To Console  ${response.status_code}
#      Log To Console  ${response.headers}
#      Log To Console  ${response.reason}
#      Log To Console  ${response.json()}[name]


*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}
${json}=  catenate   {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","souhlas":true}


*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","souhlas":true}   200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","souhlas":true}    500


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =          POST  ${urlapp}  data= ${json}    expected_status=${error_resp}

      Log To Console  ${resp.ok}
      Log To Console  ${resp.status_code}
      Log To Console  ${resp.headers}
      Log To Console  ${resp.reason}
      Log To Console  ${resp.json()}















#Quick Get Request Test
#      ${response}=      GET  https://www.google.com
##      Log to Console    ${response}
#
#Quick Get Request With Parameters Test
#      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
#
#Quick Get A JSON Body Test
#      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
##      Status should be  200
#      Log to Console      ${response.ok}
#      Log to Console      ${response.headers}
#      Log to Console      reason: ${response.reason}
#      Log to Console      status_code: ${response.status_code}
#      Log to Console      text: ${response.text}
#      Log to Console      ${response.json()}
#      Log to Console      ${response.json()}[title]
#      Log to Console      ${response.json()}[userId]
#      Log To Console      ${response.json()}.id
#
#    Should Be Equal As Strings    OK  ${response.reason}
#
##&{dict} =    userId=1  id=1  title='sunt'  body='quia et suscipit'
##{'userId': 1, 'id': 1, 'title': 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit', 'body': 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'}
#    Should Be Equal As Strings    1  ${response.json()}[userId]
#    Should Be Equal As Strings    1  ${response.json()}[id]
#    Should Be Equal As Strings    sunt aut facere repellat provident occaecati excepturi optio reprehenderit  ${response.json()}[title]



#Test Registrace na Kurz
#  ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#
#  ${response}=    POST  ${urlapp}  data=${json}  expected_status=200
#
#
#Test Registrace na Kurz chyba
#  ${json}=  catenate  {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#
#  ${response}=    POST  ${urlapp}  data=${json}  expected_status=500



#
#Chybny format dat místo DATA pouzit JSON
#    ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#    POST    ${urlapp}   json=${json}  expected_status=500
#
#Vše OK
#    ${json}=        catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#    ${response}=    POST    ${urlapp}   data=${json}  expected_status=200
#    log to console  ${response.json()}[response]
#
#
#Chybné číslo kurzu
#    ${json}=  catenate  {"targetid":"","kurz":"5","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#    ${response}=  POST    ${urlapp}   data=${json}  expected_status=200
#
#    #Pozor na psani a nepsaní kulatých závorek
##    log to console  ${response.json}
#    log to console  ${response.json()}
#    log to console  ${response.json()}[response]
#    log to console  ${response.json()}[reason]
##    log to console  ${response.text}
#
#
#
#
#

















