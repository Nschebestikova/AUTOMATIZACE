*** Settings ***
Library    Collections
Library	    RequestsLibrary

*** Variables ***
${URL}                    https://api.spotify.com
${ALBUM_ID}               /v1/albums/4aawyAB9vmqN3uQ7FjRGTy
${URL_ALBUM}              ${URL}${ALBUM_ID}
${access_token}           BQD_dz6hbzvmz8j4PVjfY6DmnTFQR4775HSY13K6KMJr9Mpoyjd5kbz550uff1ixeAtDgLdmensqxsUy4jKXaDz3oWXHJXpsV25gNvA-XI69wbmEtl4

*** Test Cases ***
Spotify - albums
    ${headers}=         Create Dictionary  Authorization=Bearer ${access_token}
    ${resp} =           GET  ${URL_ALBUM}  headers=${headers}  expected_status=200

    Log To Console      ${resp.json()}[album_type]

