
*** Settings ***
Library              RequestsLibrary


*** Test Cases ***
Quick Get Request Test
      ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
      Should Be Equal As Strings    1  ${response.json()}[id]
#      Log to Console    >>>>${response}<<<<<
       Log To Console    >>>>${response.ok}<<<<
#      Log To Console    >>>>${response.headers}<<<<
#      Log To Console    >>>${response.reason}<<<<
#      Log To Console    >>>>${response,status_code}<<<<
       Log To Console    >>>>>${response.json()}[title]<<<<<

JSON Body test
     ${response}=    GET  https://jsonplaceholder.typicode.com/albums
     Log To Console    >>>>${response.ok}<<<<
#     Log To Console    >>>>>${response.json()}[]<<<<<
