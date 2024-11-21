*** Settings ***
Library            RequestsLibrary       #https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html

*** Test Cases ***
Quick Get Request Test
      ${response}=    GET  https://www.google.com
      Log To Console    ${response}

Quick Get Request With Parameters Test
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200 
#      Status Should Be    200

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
#      Log To Console    ${response.ok}
#      Log To Console    ${response.headers}
#      Log To Console    ${response.status_code}
#      Log To Console    ${response.reason}
#       Log To Console    ${response.json()}
      Log To Console    ${response.json()}[userId]
      Should Be Equal As Strings    1  ${response.json()}[id]

Quick Get A JSON Body Test2
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
#      Log To Console    ${response.ok}
#      Log To Console    ${response.headers}
#      Log To Console    ${response.status_code}
#      Log To Console    ${response.reason}
#      Log To Console   ${response.json()}
      Log To Console     ${response.json()}[id]
      Should Be Equal As Strings    2  ${response.json()}[id]

Dotaz na dokumentaci Kitner Test
    Log To console
