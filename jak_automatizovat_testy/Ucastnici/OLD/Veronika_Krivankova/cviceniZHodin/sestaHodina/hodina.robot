*** Settings ***
Library               RequestsLibrary

*** Test Cases ***
Quick Get Request Test
      ${response}=    GET  https://www.google.com
#zde nemáme kontrolu, že to musí dopadnout 200

Quick Get Request With Parameters Test
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
#zde máme kontrolu, že to musí dopadnout 200

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
#      Should Be Equal As Strings    1  ${response.json()}[id]
      Log To Console    >>>>>>>>>${response}<<<<<<<<<<

#vypíše 200
      Log To Console    >>>>>>>>>${response.ok}<<<<<<<<<<

#např když se potřebuji autorizovat:
      Log To Console    >>>>>>>>>${response.headers}<<<<<<<<<<

#reason je OK a status_code 200
      Log To Console    >>>>>>>>>${response.reason}<<<<<<<<<<
      Log To Console    >>>>>>>>>${response.status_code}<<<<<<<<<<

#text
      Log To Console    >>>>>>>>>${response.reason}<<<<<<<<<<

#json
      Log To Console    >>>>>>>>>${response.json()}<<<<<<<<<<
