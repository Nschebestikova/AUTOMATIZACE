
*** Settings ***
Library  RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

Prvni API test
      ${response}=      GET  https://www.google.com
      Status Should Be  200
      Log to Console    ${response}

quick test
       ${response}=      GET  https://www.google.com/search  params=query=ciao  expected_status=200

        # nebo
       ${response}=      GET  https://www.google.com/search  params=query=ciao
       Status Should Be    200

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/5
      Should Be Equal As Strings    nesciunt quas odio  ${response.json()}[title]


Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/3
      Should Be Equal As Strings    ea molestias quasi exercitationem repellat qui ipsa sit aut  ${response.json()}[title]


      Log To Console  ${response.ok}
      Log To Console  ${response.status_code}
      Log To Console  ${response.headers}
      Log To Console  ${response.reason}
      Log To Console  ${response.json()}[id]



















