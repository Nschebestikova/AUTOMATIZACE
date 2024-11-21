*** Settings ***
Library  RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

#Prvni API test
#      ${response}=      GET  https://www.google.com
#      Status Should Be   200
##      Log to Console    ${response}
#
#Druhy API test
#      ${response}=      GET  https://www.google.com/seach  params=query=ciao   expected_status=403
#      Status Should Be   403

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
      Should Be Equal As Strings    1  ${response.json()}[id]

      Log To Console  ${response.ok}
#      Log To Console  ${response.status_code}
      Log To Console  ${response.headers}
      Log To Console  ${response.reason}
#      Log To Console  ${response.json()}[id]







