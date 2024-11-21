#NEFUNKCNI TEST, NEVIM, JAK TO NAPSAT


*** Settings ***
Library  RequestsLibrary
Library  String
#Library  Collections

*** Variables ***
${url}		    https://developer.spotify.com/documentation/web-api
${app}          http://open.spotify.com
${urlapp}   ${url}${app}


*** Test Cases ***

zobrazení info o umělci
    Artist information     ???  Rock  0k17h0D3J5VfsdmQ1iZtE9  Pink Floyd  ??  artist  200



*** Keywords ***

Artist information
    [Arguments]      ${followers}  ${genres}  ${id}    ${name}  ${popularity}  ${type}   ${response_code}
    
    
    ${json}=  Catenate
#...  {"external_urls":"${external_urls}",
...  "followers":"${followers}",
...  "genres":"${genres}",
#...  "href":"${href}",
...  "id":"${id},
#...  "images":"${images}",
...  "name":"${name}",
...  "popularity":"${popularity}",
...  "type":"${type}",
#...  "uri":"${uri}}

  ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

  ${resp} =           GET  ${urlapp}  data=${json_utf8}  expected_status=Anything

  Log                 Response: @{resp}
  Status Should Be      ${response_code}  #kontroluje status kod
  Should Be Equal       ${resp.json()}[response]   ${response_code}   #kontroluje status v těle
