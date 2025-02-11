#lepsi a prehlednejsi informace pri spusteni v terminalu, tj. robot lekce_6_api.robot

*** Settings ***
Library               RequestsLibrary

*** Test Cases ***
Quick Get Request Test
    ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
    ${response}=    GET  https://www.google.com/search  params=query=ahoj  expected_status=200

Quick Get Request With Parameters Test
    #expected_status - pokud nedam, tak mi to muze zhucet, lepsi je dat expected_status=anything
    ${response}=    GET  https://www.google.com/search  params=query=ahoj   expected_status=anything
    Status Should Be    200

Quick Get A JSON Body Test
    ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
    #Log To Console    ${response.headers}   #vytahnu do console obsah headers z jsonu
    #Log To Console    ${response.status_code}
    #Log To Console    ${response.reason}
    Log To Console    ${response.json()}[id]
    Should Be Equal As Strings    2  ${response.json()}[id]
