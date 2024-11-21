
*** Settings ***
Library  RequestsLibrary
Library  String

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace dlouhy telefon
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"6081231236546544654654654654","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace prazdne pole telefon
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace specialni znak ve jmene
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"@Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500



*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}
    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =          POST  ${urlapp}  data=${json}   expected_status=${error_resp}







