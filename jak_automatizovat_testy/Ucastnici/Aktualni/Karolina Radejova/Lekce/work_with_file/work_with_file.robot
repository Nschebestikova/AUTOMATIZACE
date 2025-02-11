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

*** Test Cases ***
Save list to file - PRAHA
    Save list to file               ${URL}${URL_praha}       ${FILE_overview_praha}

Read data from file and convert it back to list - PRAHA
    Read from file                  ${FILE_overview_praha}

Save list to file - BRNO
    Save list to file               ${URL}${URL_brno}        ${FILE_overview_brno}

Read data from file and convert it back to list - BRNO
    Read from file                  ${FILE_overview_brno}

Save list to file - OSTRAVA
    Save list to file               ${URL}${URL_ostrava}     ${FILE_overview_ostrava}

Read data from file and convert it back to list - OSTRAVA
    Read from file                  ${FILE_overview_ostrava}

Save list to file - OSTATNI
    Save list to file               ${URL}${URL_ostatni}     ${FILE_overview_ostatni}

Read data from file and convert it back to list - OSTATNI
    Read from file                  ${FILE_overview_ostatni}

*** Variables ***

*** Keywords ***
Save list to file
    [Arguments]     ${url}      ${file}

    #delete content of file before writing current info from URL
    Remove File     ${file}

    New Page                    ${url}

    #accept consent dialog
    Consent dialog

    #empty list for writing values from URL
    @{IR_list} =    Create List

    #count of ice rinks in page
    ${count_of_ice_rinks} =     Get Element Count     ${SEL_IR_title}
    Log                         Count: ${count_of_ice_rinks}

    #saving the dictionary with IR values to list
    FOR     ${counter}    IN RANGE       ${count_of_ice_rinks}
            ${title} =      Get Text    ${SEL_IR_title} >> nth=${counter}
            Log    Title: ${title}
            ${photo} =      Get Attribute    ${SEL_IR_photo} >> nth=${counter}    src
            Log    Photo: ${photo}
            ${status} =     Get Text    ${SEL_IR_status}
            Log    Status: ${status}

            &{dictionary} =     Create Dictionary   title=${title}      photo=${photo}      status=${status}
            Log Many        &{dictionary}

            #append dictionary with values of IR to list
            Append To List    ${IR_list}    ${dictionary}

    END
    Log Many    @{IR_list}

    ${semicolon} =      Set Variable    ;
    ${space} =          Set Variable    ${\n}

    #set every item in list to new line and separate it with selected separator
    ${string_letters} =     Catenate    SEPARATOR=${semicolon}${space}       @{IR_list}
    Log                     ${string_letters}

    #add items separated with newline and selected separator to file
    Append To File      path=${file}    content=${string_letters}   encoding=UTF-8
    Log                 Data were added to file

    #verification that file exists and it is not empty
    File Should Exist           ${file}
    File Should Not Be Empty    ${file}

Read from file
    [Arguments]     ${file}

    #confirmation that file exists and it is not empty
    Get File                    ${file}
    File Should Exist           ${file}
    File Should Not Be Empty    ${file}

    #saving the content of file to variable
    ${content_file} =       Log File    ${file}
    Log                     ${content_file}

    #removing the new lines and commas from items in file
    ${string_content_without_separators} =      Catenate    ${content_file.replace('\n', '')}
    Log                     ${string_content_without_separators}

    #saving the items back to list (probably working only for string e.g. Akjhsdiug) - it need to be tested for string e.g. Brno - Kluziste Vodova
    ${separator} =  Set Variable    ;
    @{IR_list} =    Split String    ${string_content_without_separators}    ${separator}
    Log Many    @{IR_list}


Consent dialog
    Take Screenshot
    ${count} =   Get Element Count   ${SEL_consent_dialog_btn_consent}
    Log                 ${count}
    Run Keyword If      ${count}>0    Click    ${SEL_consent_dialog_btn_consent}
    Take Screenshot

Before_suite
   New Browser                  chromium   headless=False
   Sleep                        ${SLEEP_BEFORE_TEST}

Before_test
   New Browser                  chromium   headless=False
   #New Page                    ${URL}
   Set Browser Timeout          ${TimeOut_Browser}
   Sleep                        ${SLEEP_BEFORE_TEST}
   Set Strict Mode              off

After_test
    #Go To                      ${URL}
    Close Browser

After_suite
    Close Browser
