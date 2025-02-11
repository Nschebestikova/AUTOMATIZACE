*** Settings ***
Library         RequestsLibrary
Library	        Collections
Library         String
Resource        TestData/ProjectData.robot

*** Test Cases ***
Pos tests |novak1
    login       ${NAMEsmallnovak}       ${PASSWORDnovakG}      ${browserchro}       200
    login       ${NAMEsmallnovak}       ${PASSWORDnovakG}      ${browsermozz}       200
    login       ${NAMEsmallnovak}       ${PASSWORDnovakG}      ${browsersa}       200

Pos tests |Novak2
    login        ${NameFirstLargenovak}      ${PASSWORDnovakG}      ${browserchro}       200
    login        ${NameFirstLargenovak}      ${PASSWORDnovakG}      ${browsermozz}       200
    login        ${NameFirstLargenovak}      ${PASSWORDnovakG}      ${browsersa}       200

Pos tests |NOVAK3
    login    ${NAMEcapslocknovak}       ${PASSWORDnovakG}      ${browserchro}       200
    login    ${NAMEcapslocknovak}       ${PASSWORDnovakG}      ${browsermozz}       200
    login    ${NAMEcapslocknovak}       ${PASSWORDnovakG}      ${browsersa}       200

Pos tests |admin1
    login       ${NAMEsmalladmin}       ${PASSWORDadminG}      ${browserchro}       200
    login       ${NAMEsmalladmin}       ${PASSWORDadminG}      ${browsermozz}       200
    login       ${NAMEsmalladmin}       ${PASSWORDadminG}      ${browsersa}       200

Pos tests |Admin2
    login        ${NameFirstLargeadmin}      ${PASSWORDadminG}      ${browserchro}       200
    login        ${NameFirstLargeadmin}      ${PASSWORDadminG}      ${browsermozz}       200
    login        ${NameFirstLargeadmin}      ${PASSWORDadminG}      ${browsersa}       200

Positive tests |ADMIN3
    login    ${NAMEcapslockadmin}       ${PASSWORDadminG}      ${browserchro}       200
    login    ${NAMEcapslockadmin}       ${PASSWORDadminG}      ${browsermozz}       200
    login    ${NAMEcapslockadmin}       ${PASSWORDadminG}      ${browsersa}       200

Neg tests |zamena
    login    ${NAMEsmallnovak}    ${PASSWORDadminG}    ${browserchro}    403
    login    ${NAMEsmallnovak}    ${PASSWORDadminG}    ${browsermozz}    403
    login    ${NAMEsmallnovak}    ${PASSWORDadminG}    ${browsersa}    403
    login    ${NAMEsmalladmin}    ${PASSWORDnovakG}    ${browserchro}    403
    login    ${NAMEsmalladmin}    ${PASSWORDnovakG}    ${browsermozz}    403
    login    ${NAMEsmalladmin}    ${PASSWORDnovakG}    ${browsersa}    403

Neg tests |all empty
    login    ${Nevyplneno}    ${Nevyplneno}    ${Nevyplneno}    403

Neg tests |password empty admin
    login    ${NAMEsmalladmin}    ${Nevyplneno}    ${browserchro}    403
    login    ${NAMEsmalladmin}    ${Nevyplneno}    ${browsermozz}    403
    login    ${NAMEsmalladmin}    ${Nevyplneno}    ${browsersa}    403

Neg tests |password empty novak
    login    ${NAMEsmallnovak}    ${Nevyplneno}    ${browserchro}    403
    login    ${NAMEsmallnovak}    ${Nevyplneno}    ${browsermozz}    403
    login    ${NAMEsmallnovak}    ${Nevyplneno}    ${browsersa}    403

Neg tests |browser empty
    login    ${NAMEsmallnovak}    ${PASSWORDnovakG}    ${Nevyplneno}    403
    login    ${NAMEsmalladmin}    ${PASSWORDadminG}    ${Nevyplneno}    403

Neg tests |name empty admin
    login    ${Nevyplneno}    ${PASSWORDadminG}    ${browsersa}   403
    login    ${Nevyplneno}    ${PASSWORDadminG}    ${browserchro}   403
    login    ${Nevyplneno}    ${PASSWORDadminG}    ${browsermozz}   403

Neg tests |name empty novak
    login    ${Nevyplneno}    ${PASSWORDnovakG}    ${browsersa}   403
    login    ${Nevyplneno}    ${PASSWORDnovakG}    ${browserchro}   403
    login    ${Nevyplneno}    ${PASSWORDnovakG}    ${browsermozz}   403

Neg tests |numbers in browser
     login       ${NAMEsmallnovak}       ${PASSWORDnovakG}      ${num}   403
     login       ${NAMEsmalladmin}       ${PASSWORDadminG}      ${num}  403

Neg tests |numbers in name
    login       ${num}       ${PASSWORDnovakG}      ${browserchro}       403
    login       ${num}       ${PASSWORDnovakG}      ${browsermozz}       403
    login       ${num}       ${PASSWORDnovakG}      ${browsersa}       403
    login       ${num}       ${PASSWORDadminG}      ${browserchro}       403
    login       ${num}       ${PASSWORDadminG}      ${browsermozz}       403
    login       ${num}       ${PASSWORDadminG}      ${browsersa}       403

Neg tests |numbers in password novak
    login       ${NAMEsmallnovak}       ${num}      ${browserchro}       403
    login       ${NAMEsmallnovak}       ${num}      ${browsermozz}       403
    login       ${NAMEsmallnovak}       ${num}      ${browsersa}       403

Neg tests |numbers in password admin
    login       ${NAMEsmalladmin}       ${num}      ${browserchro}       403
    login       ${NAMEsmalladmin}       ${num}      ${browsermozz}       403
    login       ${NAMEsmalladmin}       ${num}      ${browsersa}       403

Neg test |all numbers
    login    ${num}    ${num}    ${num}    403

Neg tests |interpunkce novak
    login    ${NAMEnabodenickanovak}    ${PASSWORDnovakNABODENICKA}    ${browserchro}    403
    login    ${NAMEnabodenickanovak}    ${PASSWORDnovakNABODENICKA}    ${browsersa}    403
    login    ${NAMEnabodenickanovak}    ${PASSWORDnovakNABODENICKA}    ${browsermozz}    403

Neg tests |interpunkce admin
    login    ${NAMEnabodenickaadmin}    ${PASSWORDadminNABODENICKA}    ${browserchro}    403
    login    ${NAMEnabodenickaadmin}    ${PASSWORDadminNABODENICKA}    ${browsersa}    403
    login    ${NAMEnabodenickaadmin}    ${PASSWORDadminNABODENICKA}    ${browsermozz}    403

Neg tests |novak typing error in password
    login       ${NAMEsmallnovak}       ${PASSWORDnovakW}      ${browserchro}       403
    login       ${NAMEsmallnovak}       ${PASSWORDnovakW}      ${browsermozz}       403
    login       ${NAMEsmallnovak}       ${PASSWORDnovakW}      ${browsersa}       403

Neg tests |admin typing error in password
    login        ${NAMEsmalladmin}      ${PASSWORDadminW}      ${browserchro}       403
    login        ${NAMEsmalladmin}      ${PASSWORDadminW}      ${browsermozz}       403
    login        ${NAMEsmalladmin}      ${PASSWORDadminW}      ${browsersa}       403

Neg tests |special figures in password novak
    login       ${NAMEsmallnovak}       ${PASSWORDnovakSpecial}      ${browserchro}       403
    login       ${NAMEsmallnovak}       ${PASSWORDnovakSpecial}      ${browsermozz}       403
    login       ${NAMEsmallnovak}       ${PASSWORDnovakSpecial}      ${browsersa}       403

Neg tests |special figures in password admin
    login       ${NAMEsmalladmin}       ${PASSWORDadminSpecial}      ${browserchro}       403
    login       ${NAMEsmalladmin}       ${PASSWORDadminSpecial}     ${browsermozz}       403
    login       ${NAMEsmalladmin}       ${PASSWORDadminSpecial}      ${browsersa}       403

*** Keywords ***
login
    [Arguments]       ${name}  ${password}  ${bro}  ${err}
    ${json} =  Catenate  {"username":"${name}","password":"${password}","useragent":"${bro}"}
    ${json_utf8} =   Encode String To Bytes   ${json}  UTF-8
    ${resp} =          POST  ${urlapp2}  data=${json_utf8}  expected_status=${err}
    Log To Console     ${resp.json()}[response]
    Status Should Be    ${err}
