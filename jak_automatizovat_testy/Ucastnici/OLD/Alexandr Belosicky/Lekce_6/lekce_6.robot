*** Settings ***
Library         RequestsLibrary     #to je knihovna na přistupování k API, je potřeba nainstalovat přes windows terminál

*** Variables ***
${url} =  http://testovani.kitner.cz/
${app} =  regkurz/formsave.php
${urlapp}  ${url}${app}


*** Test Cases ***
Quick Get Request Test   #jednoduchý test bez kontroly a parametrů
    ${response} =  GET  https://www.google.com

Quick Get Request With Parameters Test    #test na API vč. vložení parametru (vyhledání slova ciao)
    ${response} =  GET  https://www.google.com/search  params=query=ciao   expected_status=200  #tento zápis/kontrola statusu 200 má výhodu oproti zápisu níže, že fatal error neskončí chybou, když tam dám číslo chyby
#    Status Should Be    200   #tento zápis má nevýhodu, když JSON skončí velkou chybou, tak to nedoběhne, protože FAIL by nastal v řádku výše

Quick Get A JSON Body Test   #test dotaz na API na title a kontrola
    ${response} =   GET  https://jsonplaceholder.typicode.com/posts/5
#    Should Be Equal As Strings    5   ${response.json()}[id]
    Should Be Equal As Strings    nesciunt quas odio   ${response.json()}[title]

#   Log To Console    ${response.ok}    #tento zápis vrací TRUE nebo FALSE, podle toho jak to dopadne
#   Log To Console    ${response.status_code}    #vytáhne status kód
#   Log To Console    ${response.headers}   #vytáhne hlavičky (typ API, kódování, autentizace
    Log To Console    ${response.reason}    #když dotaz dopadne špatně, tak v reason je ta chybová hláška, např. 403 - špatně heslo
    Log To Console    ${response.json()}[id]

Registrace na kurz
    ${json} =  Catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response} =  POST  ${urlapp}  data=${json}
    Status Should Be    200


