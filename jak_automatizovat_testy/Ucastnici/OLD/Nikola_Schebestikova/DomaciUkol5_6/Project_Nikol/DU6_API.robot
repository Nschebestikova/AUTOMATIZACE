*** Settings ***
Library	    RequestsLibrary
Library     String
Library     Collections
#Library    FakeLibrary - myslím si,že pro opakovaný test k registraci by bylo dobré mít fake library, případně více dat -
#... protože mi to NA TOM spadlo ten test ok

Resource    ../Project_Nikol/Data_and_Config/TestData_API.robot
Resource    ../Project_Nikol/Data_and_Config/Configuration_API.robot

#možno před každými testy použit Suite Steup - místo mít to v Kewords? a Open browser a timeouty
#Suite Teardown  Uklid po testech

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}


#TOTO TI BÝT NEMUSÍ, BERE SI TO Z LIBRARY ALE PRO JISTOTU NECHÁVÁM
*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

*** Test Cases ***
Registrace v pořádku - správné hodnoty v JSON body
    API Comunication   ${jsonBODY_OK}     200
    Sleep    5s
    API GET CHECK REGISTRACE USERA S CORRECT DATY  ${email_1}

Registrace bez volby kurzu - negative TC
    API Comunication   ${jsonBODY_NOKURZ}   500

Registrace volby telefonu - prázdný telefon
    API Comunication   ${jsonBODY_PHONE_EMPTY}   500

Registrace chybny telefon - VALIDACE (KRÁTKÝ TELEFON)
    API Comunication    ${jsonBODY_PHONE}   500

Registrace chybny email (spatny email VALIDACE)
   API Comunication     ${jsonBODY_EMAIL}  500

Registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy, špatné uvozovky...)
    API Comunication        ${jsonBODY_NOTGOOD}     500

Registrace - chybný prázdný e-mail
   API Comunication     ${jsonBODY_EMPTY_E_EMAIL}      500


#testovat JSON, zda obsahuje klíč s hodnotou
# Dictionary Should Contain Item    ${resp.json()}    response    200  - lze takto

Registrace na kurz platné udaje prav
    Registrace na kurz API

*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}


#Registrace na kurz
#   [Arguments]      ${x}    ${kurz}     ${jmeno}    ${prijmeni}     ${}

#tvorba JSONU

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}

    #ŠLO BY TOTO A PAK I KONTROLY UDĚLAT PŘES CYKLUS FOR - NĚJAK EASY, PRO OPAKOVANÉ ZADÁNÍ A JEŠTĚ OTÁZKA,JAK NA TO NAVÁZAT, ABY SI TO VYPLŇOVÁNÍ BRALO A FAKERLIBRARY
    #... MŮŽEME PROBRAT NA HODINĚ



API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_u8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_u8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}

  Log To Console  ${resp.status_code}

#Kontrola, jak zjistit zaregistrovaný e-mail správně
API GET CHECK REGISTRACE USERA S CORRECT DATY
    [Arguments]     ${email}
    ${response_get} =   Get     ${URLREGISTRLIST}       expected_status=Anything
    #log  A VÝPIS GET response - správně
    Log    ${response_get.content}

   #convert response content to string type
    ${response_string} =    Convert To String       ${response_get.content}

    #ověření response_stringu Obsahu - správný/zadaný e-mail a výpis do logu
    Should Contain    ${response_string}        ${email_1}
    Log               Response contains correct email from registration.


#Uklid po testech
#    Close Browser