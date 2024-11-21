*** Settings ***
Library         RequestsLibrary
Library         String

*** Variables ***
${url} =  http://testovani.kitner.cz/
${app} =  regkurz/formsave.php
${urlapp}  ${url}${app}

*** Test Cases ***
Česká diakritika ve jménu - pozitivní
    API Comunication   {"targetid":"","kurz":"2","name":"Alexšěéáíýž","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

Česká diakritika v příjmení - pozitivní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svobodašěéáíýž","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

Bez volby kurzu - negativní
    API Comunication   {"targetid":"","kurz":"","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Bez jména - negativní
    API Comunication   {"targetid":"","kurz":"3","name":"","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Bez příjmení - negativní
    API Comunication   {"targetid":"","kurz":"3","name":"Alex","surname":"","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Bez volby fyz-pra - negativní
    API Comunication   {"targetid":"","kurz":"3","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Prázdné IČO u právnické osoby - negativní
    API Comunication   {"targetid":"","kurz":"3","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"","count":"1","comment":null,"souhlas":true}  500

Správný formát IČO u právnické osoby - pozitivní
    API Comunication   {"targetid":"","kurz":"3","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"49901869","count":"1","comment":null,"souhlas":true}  200

Nesprávný formát IČO u právnické osoby - negativní
    API Comunication   {"targetid":"","kurz":"3","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"123456789","count":"1","comment":null,"souhlas":true}  500

Prázdný počet osob - negativní
    API Comunication   {"targetid":"","kurz":"3","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"","count":"","comment":null,"souhlas":true}  500

Chybný formát JSON - negativní
    API Comunication   {kurz":"1","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Chybný formát emailu, chybí @ - negativní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novakabc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Chybný formát emailu, chybí začátek - negativní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Chybný formát emailu, chybí doména - negativní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novak@.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Chybný formát emailu, chybí .cz - negativní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novak@abc","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Chybný formát počtu osob 0 - negativní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"0","comment":null,"souhlas":true}  500

Chybný formát počtu osob TEXT - negativní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"text","comment":null,"souhlas":true}  500

Chybný formát tel. čísla - negativní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"+4206081231234","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Tel. číslo vč. +420 - pozitivní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"+420608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

Včetně komentáře - pozitivní
    API Comunication   {"targetid":"","kurz":"2","name":"Alex","surname":"Svoboda","email":"jan.novak@abc.cz","phone":"+420608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":"zkušební komentář","souhlas":true}  200


*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}
    ${json_utf8} =   Encode String To Bytes   ${json}    UTF-8
    ${resp} =          POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log   ${resp.json()}
    Status Should Be   ${error_resp}

