* Settings *
Library               RequestsLibrary

* Test Cases *
Quick Get Request Test
   ${response}=    GET  https://www.google.com
   Log        ${response}

Quick Get Request With Parameters Test
   ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
#   Status Should Be    200
   Log To Console    ${response.status_code}

Quick Get A JSON Body Test
   ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
   Should Be Equal As Strings    1  ${response.json()}[id]

Quick Get A JSON Body Test 2
   ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
   Should Be Equal As Strings    2  ${response.json()}[id]

Quick Get A JSON Body Test - title
   ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
   Should Be Equal As Strings    qui est esse  ${response.json()}[title]

Quick Get A JSON Body Test - userId
   ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
   Should Be Equal As Strings    1  ${response.json()}[userId]
   Log To Console    ${response.json()}[userId]