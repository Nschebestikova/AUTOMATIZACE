*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    Lib/base64.py
Variables  test_data.py


*** Variables ***
${URL}                    https://api.spotify.com/
${SHOW}                   v1/shows/7wXmNMjOhLQ53QyGpYT4k0
${URL_WITH_SHOW_ID}       ${URL}${SHOW}


*** Test Cases ***
Spotify - ALEF SecurityCast

#access token
    ${base64encoded_client_id_and_secret}=    Evaluate    base64.b64encode('${CLIENT_ID}:${CLIENT_SECRET}'.encode('ascii'))

    ${headers} =     Create Dictionary   content-type=application/x-www-form-urlencoded      Authorization=Basic ${base64encoded_client_id_and_secret}

    ${body} =       Create Dictionary    grant_type=client_credentials
    ${resp} =       Post                 ${OAUTH_TOKEN_URL}  headers=${headers}  data=${body}  expected_status=200

#odpověď na Requests access token
#    Log                 ${resp.json()}
#    Log To Console      ${\n} Odpověď na Requests access token:
#    Log To Console      access_token = ${resp.json()}[access_token]
#    Log To Console      token_type = ${resp.json()}[token_type]
#    Log To Console      expires_in = ${resp.json()}[expires_in]
#    Log To Console      ${\n}
    ${access_token}     Set Variable  ${resp.json()}[access_token]


    ${headers}=         Create Dictionary  Authorization=Bearer ${access_token}
    ${resp} =           GET  ${URL_WITH_SHOW_ID}  headers=${headers}  expected_status=200

 #  Logování
    Log                 description:${resp.json()}[description]       level=INFO
    Log                 name :${resp.json()}[name]                    level=INFO
    Log                 episode description :${resp.json()}[episodes][items][0][description]        level=INFO      #popis poslední epizody
