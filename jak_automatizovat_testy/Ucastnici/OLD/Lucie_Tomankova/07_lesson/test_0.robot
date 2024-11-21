*** Settings ***
Library               RequestsLibrary

*** Test Cases ***
Quick Get Request Test
  ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
  ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200

Quick Get A JSON Body Test
  ${re}=    GET  https://jsonplaceholder.typicode.com/posts/1
  Should Be Equal As Strings    1  ${re.json()}[id]
  Should Be Equal As Strings    sunt aut facere repellat provident occaecati excepturi optio reprehenderit  ${re.json()}[title]
  Log To Console    ${re}
  Log To Console    ${re.status_code}
  Log To Console    ${re.ok}
  Log To Console    ${re.headers}
  Log To Console    ${re.url}
  Log To Console    ${re.reason}
  Log To Console    ${re.json()}
