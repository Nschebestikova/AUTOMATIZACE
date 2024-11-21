*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Library         Browser

*** Variables ***
${url}		        https://open.spotify.com
${app_playlist}     /playlist/3cEYpjA9oz9GiPac4AsH4n
${urlapp}           ${url}${app_playlist}

*** Test Cases ***
Should check at least something
  API Communication   Spotify Web API Testing playlist  JMPerez²  jmperezperez  spotify:user:jmperezperez  200

*** Keywords ***
API Communication
    [Arguments]   ${name}    ${display_name}    ${id}   ${uri}  ${response}
    ${json}=     Catenate      {"name":${name},"display_name":"${display_name}","id":"${id}","uri":"${uri}"}
    &{header}=   Create Dictionary   Accept=application/json  x-requested-with=XMLHttpRequest   charset=utf-8 user  user-agent=Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Mobile Safari/537.36
    ${resp} =    GET  ${urlapp}   data=${json}  headers=${header}  expected_status=Anything

    Status should be      ${response}

# Nedokonceno. Stav: K API jsem se dostala, ale testy padaji na erroru 405 na POST a 400 na GET