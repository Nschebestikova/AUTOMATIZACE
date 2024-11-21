*** Settings ***
Library         Collections
Library         Browser
Library         DateTime
Library         OperatingSystem
Library         String

Resource        ../../Projekt Verejne-brusleni.info/Data_and_Config/Configuration.robot
Resource        ../../Projekt Verejne-brusleni.info/Data_and_Config/TestData.robot

Suite Setup     Before_suite
Suite Teardown  After_suite

Test Setup      Before_test
Test Teardown   After_test

#
#Vytvorit KS Generator nazvu souboru
#
#    vysledny nazev souboru ma byt ve formatu rok_mesic_den_hodina_minuta_webova_adresa.data
#    pridat toto KS do TC Save to file, aby se vytvarel pokazde novy vzorovy soubor (nutne upravit i konfiguracni path - odstranit z ni nazev souboru a ten pridavat v TC jako argument)
#    v zavislosti upravit take Read from file (nazev souboru jako argument?)


*** Test Cases ***
Generate file name
    Generate name of file    ${URL}${URL_ostrava}

*** Keywords ***
Generate name of file   #Format of file name: year_month_day_hour_minutes_url
    [Arguments]             ${url}

    Log                     url: ${url}
    ${date} =               Get Current Date
    Log                     ${date}
    ${converted_date} =     Convert Date    ${date}     result_format=%Y_%m_%d_%H_%M
    Log                     ${converted_date}
    ${url_without_slash} =  Catenate    ${url.replace("/","_")}
    Log                     edited url: ${url_without_slash}
    ${file_name} =          Catenate    SEPARATOR=_   ${converted_date}   ${url_without_slash}
    Log                     ${file_name}
    [Return]                ${file_name}


Before_suite
   New Browser                  chromium   headless=False
   Sleep                        ${SLEEP_BEFORE_TEST}

Before_test
   #New Browser                  chromium   headless=False
   New Page                    ${URL}
   Set Browser Timeout          ${TimeOut_Browser}
   Sleep                        ${SLEEP_BEFORE_TEST}
   Set Strict Mode              off

After_test
    #Go To                      ${URL}
    Close Browser

After_suite
    Close Browser

Consent dialog
    Take Screenshot
    ${count} =   Get Element Count   ${SEL_consent_dialog_btn_consent}
    Log                 ${count}
    Run Keyword If      ${count}>0    Click    ${SEL_consent_dialog_btn_consent}
    Take Screenshot