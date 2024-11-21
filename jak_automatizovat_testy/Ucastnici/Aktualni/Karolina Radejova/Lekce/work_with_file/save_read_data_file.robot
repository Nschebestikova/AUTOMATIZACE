*** Settings ***
Library         Collections
Library         Browser
Library         DateTime
Library         OperatingSystem
Library         String
Library         ast

Resource        ../../Projekt Verejne-brusleni.info/Data_and_Config/Configuration.robot
Resource        ../../Projekt Verejne-brusleni.info/Data_and_Config/TestData.robot

Suite Setup     Before_suite
Suite Teardown  After_suite

Test Setup      Before_test
Test Teardown   After_test

#TO DO
#Save to file - PRAHA -> test pada, soubor neobsahuje druhe kluziste Vypich, dale jedno kluziste obsahuje znaky pro nonbreaking space
#upravit nazvy TCs a KWs

*** Variables ***

*** Test Cases ***
Save data to file - PRAHA
    Save dictionary of ice rinks to file                ${URL}${URL_praha}

#Read data from file - PRAHA
#    Read from file                  #${FILE_overview_praha}

Save data to file - BRNO
    Save dictionary of ice rinks to file                ${URL}${URL_brno}

Read data from file - BRNO
    Read from file                                      ${FILE_template_brno}

Load time of page - OSTRAVA
    Check time of response via GUI                      ${URL}${URL_ostrava}

Save data to file - OSTRAVA
    Save dictionary of ice rinks to file                ${URL}${URL_ostrava}

Read data from file - OSTRAVA
    Read from file                                      ${FILE_template_ostrava}

Save data to file - OSTATNI
    Save dictionary of ice rinks to file                ${URL}${URL_ostatni}

Read data from file - OSTATNI
    Read from file                                      ${FILE_template_ostatni}

Compare load time
    Compare load time                                   ${FILE_template_ostatni}        ${FILE_actual_ostatni}

Compare ice rinks amounts
    Compare the ice rinks amounts                       ${FILE_template_ostatni}    ${FILE_actual_ostatni}

Compare ice rinks in files
    Compare ice rinks in files                          ${FILE_template_ostrava}    ${FILE_actual_ostrava}

Compare data in files - PRAHA
    Compare load time                                   ${FILE_template_praha}      ${FILE_actual_praha}
    Compare the ice rinks amounts                       ${FILE_template_praha}      ${FILE_actual_praha}
    Compare ice rinks in files                          ${FILE_template_praha}      ${FILE_actual_praha}

Compare data in files - BRNO
    Compare load time                                   ${FILE_template_brno}       ${FILE_actual_brno}
    Compare the ice rinks amounts                       ${FILE_template_brno}       ${FILE_actual_brno}
    Compare ice rinks in files                          ${FILE_template_brno}       ${FILE_actual_brno}

Compare data in files - OSTRAVA
    Compare load time                                   ${FILE_template_ostrava}    ${FILE_actual_ostrava}
    Compare the ice rinks amounts                       ${FILE_template_ostrava}    ${FILE_actual_ostrava}
    Compare ice rinks in files                          ${FILE_template_ostrava}    ${FILE_actual_ostrava}

Compare data in files - OSTATNI
    Compare load time                                   ${FILE_template_ostatni}    ${FILE_actual_ostatni}
    Compare the ice rinks amounts                       ${FILE_template_ostatni}    ${FILE_actual_ostatni}
    Compare ice rinks in files                          ${FILE_template_ostatni}    ${FILE_actual_ostatni}


*** Keywords ***
Compare ice rinks in files
    [Arguments]     ${file_template}    ${file_actual}
    #save the data of template file to dictionary
    &{content_template} =       Read from file    ${file_template}
    Log Many                    &{content_template}
    #save the data of actual state in web to dictionary
    &{content_actual} =         Read from file    ${file_actual}
    Log Many                    &{content_actual}

    #remove page_info from content
    ${info_page_template} =     Pop From Dictionary    ${content_template}      page_info
    Log                         ${content_template}
    ${info_page_actual} =       Pop From Dictionary    ${content_actual}        page_info
    Log                         ${content_actual}

    #save keys from dictionary to list
    @{template_keys} =          Get Dictionary Keys    ${content_template}  sort_keys=True
    @{actual_keys} =            Get Dictionary Keys    ${content_actual}    sort_keys=True
    Log Many                    template keys:   ${template_keys}
    Log Many                    actual keys:     ${actual_keys}
    #check - keys are same in both files
    Lists Should Be Equal       ${template_keys}    ${actual_keys}

    #check the ice rinks values are same in both files
    FOR    ${key}    IN    @{template_keys}
        ${ir_value_template} =      Get From Dictionary    ${content_template}    ${key}
        Log                         ${key}, ${ir_value_template}
        #check the actual dictionary contains key from template file
        Dictionary Should Contain Key    ${content_actual}    ${key}
        #save the ice rink value from actual file via key from template file
        ${ir_value_actual} =        Get From Dictionary    ${content_actual}    ${key}
        #check the ice rinks values are same
        Log Many                    template: ${ir_value_template}
        Log Many                    actual: ${ir_value_actual}
        Dictionaries Should Be Equal    ${ir_value_template}    ${ir_value_actual}

    END


Compare load time
    [Arguments]     ${file_template}    ${file_actual}
    #save the data of template file to dictionary
    &{content_template} =    Read from file    ${file_template}  
    Log Many        &{content_template}
    #save the data of actual state in web to dictionary
    &{content_actual} =     Read from file    ${file_actual}
    Log Many        &{content_actual}

    #save time to variable load_time_template and load_time_actual
    ${info_page_template} =     Get From Dictionary    ${content_template}      page_info       #page_info is saved to ${info_page_template}
    ${load_time_template} =     Get From Dictionary    ${info_page_template}    load_time       #load_time is saved to ${load_time_template}
    Log    Load time from teplate file: ${load_time_template}, ${info_page_template}
    ${info_page_actual} =       Get From Dictionary    ${content_actual}        page_info
    ${load_time_actual} =       Get From Dictionary    ${info_page_actual}      load_time
    Log    Load time from file with actual state in web: ${load_time_actual}, ${info_page_actual}

    #change type of variable from string to float
    ${load_time_template} =     Remove String       ${load_time_template}      0:00:0
    ${load_time_template} =     Evaluate            float(${load_time_template})
    Log     ${load_time_template}
    ${load_time_actual} =       Remove String       ${load_time_actual}        0:00:0
    ${load_time_actual} =       Evaluate            float(${load_time_actual})
    Log     ${load_time_actual}
    
    #compare load times -> absolute value of difference (load_time_template - load_time_actual)
    ${time_difference} =    Evaluate    abs(${load_time_template} - ${load_time_actual})
    Log    ${time_difference}
    Should Be True    ${time_difference} <= ${FILE_time_difference}     msg=Test failed because the difference is bigger than approved difference

Compare the ice rinks amounts
    [Arguments]     ${file_template}    ${file_actual}
    #save the template data to dictionary
    &{content_template} =    Read from file    ${file_template}
    Log Many        &{content_template}
    #save the data of actual state in web to dictionary
    &{content_actual} =     Read from file    ${file_actual}
    Log Many        &{content_actual}

    #remove page_info from content
    ${info_page_template} =     Pop From Dictionary    ${content_template}      page_info       
    Log    ${content_template}
    ${info_page_actual} =       Pop From Dictionary    ${content_actual}        page_info
    Log    ${content_actual}
    
    #compare amounts of ice rinks in files
    ${length_template} =    Get Length    ${content_template}
    ${length_actual} =      Get Length    ${content_actual}
    Log    template: ${length_template}, actual: ${length_actual}
    Should Be True    ${length_template} == ${length_actual}     msg=Test failes because amounts of ice rinks in files is different
    
Save dictionary of ice rinks to file
    [Arguments]     ${url}

    #load time is saved as string
    ${load_time} =      Check time of response via GUI    ${url}
    Log    Load time: ${load_time}

    #accept consent dialog
    Consent dialog

    #empty list for writing values from URL
    &{IR_dict} =    Create Dictionary

    #first dictionary with info from page
    ${title_page} =         Get Title
    Log    Title of page: ${title_page}

    #Append the page information to dictionary
    ${info_dict} =      Create Dictionary       title_of_page=${title_page}     load_time=${load_time}

    #${info_dict} contains information about page, e.g. title of page, load time
    Set To Dictionary       ${IR_dict}      page_info=${info_dict}
    Log Many                &{IR_dict}

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
            Set To Dictionary    ${IR_dict}    ${title}=${dictionary}

    END
    Log Many    &{IR_dict}

    #check the count ice rinks displayed in web is same as count of ice rinks in the dictionary
    ${IR_dict_length} =     Get Length    ${IR_dict}
    Log     ${IR_dict_length}

    # -1 -> count of dictionaries in whole dictionary - page_info = count of ice rinks dictionaries
    ${IR_dict_length_minus_info} =      Evaluate    ${IR_dict_length}-1
    Log    Pocet kluzist v dictionary: ${IR_dict_length_minus_info}
    Should Be Equal    ${count_of_ice_rinks}    ${IR_dict_length_minus_info}

    #save dictionary to string variable
    ${string_dict} =     Catenate    SEPARATOR=       ${IR_dict}

    #edit string to string of dictionaries where every dictionary is in the new line
    ${string_dict} =    Replace String    ${string_dict}    },    },\n
    Log                     ${string_dict}

    #generate name of file
    ${file_name} =  Generate name of file    ${url}
    Log    Generated name of file: ${file_name}
    ${new_file} =   Catenate    SEPARATOR=      ${FILE_path}    ${file_name}    ${FILE_extension}
    Log    ${new_file}

    #add items separated with newline and selected separator to file
    Append To File      path=${new_file}    content=${string_dict}   encoding=UTF-8
    Log                 Data were added to file

    #verification that file exists and it is not empty
    File Should Exist           ${new_file}
    File Should Not Be Empty    ${new_file}
    [Return]                    ${new_file}

Read from file
    [Arguments]     ${file}

    #confirmation that file exists and it is not empty
    Get File                    ${file}
    File Should Exist           ${file}
    File Should Not Be Empty    ${file}

    #saving the content of file to variable
    ${content_file} =       Log File    ${file}
    Log                     ${content_file}

    #remove new lines from content of file
    ${string_dict} =    Replace String    ${content_file}    },\n    },
    Log                     ${string_dict}

    #convert string to dictionary
    &{content_dict} =       Evaluate    ast.literal_eval($string_dict)  #https://docs.python.org/3/library/ast.html - odkaz na dokumentaci, literal_eval() function evaluates the string to python literal, in this case to dictionary
    Log Many                &{content_dict}
    [Return]                ${content_dict}


Check time of response via GUI
    [Arguments]                 ${url}
    ${start_time} =             Run    ${time_command}
    Log                         Start Time: ${start_time}
    New Page                    ${url}
    Wait For Elements State     xpath=//*[contains(text(), 'Copyright')]      visible
    Take Screenshot
    ${end_time} =               Run    ${time_command}
    Log                         End Time: ${end_time}
    ${result_time} =            Evaluate    datetime.datetime.strptime('${end_time}', '%H:%M:%S.%f') - datetime.datetime.strptime('${start_time}', '%H:%M:%S.%f')
    ${result} =                 Evaluate    str("${result_time}")
    Log                         Response time: ${result}
    [Return]                    ${result}

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


Read the ice rinks in page
    [Arguments]                 ${url}
    New Page                    ${url}

    Consent dialog

    ${count_of_ice_rinks} =     Get Element Count     ${SEL_IR_title}
    Log                         Count: ${count_of_ice_rinks}
    @{IR_list} =                Create List

    FOR     ${counter}    IN RANGE       ${count_of_ice_rinks}
            ${ice_rink_name} =           Get Text    ${SEL_IR_title} >> nth=${counter}
            Log                          Ice rink name: ${ice_rink_name}
            Append To List               ${IR_list}    ${ice_rink_name}
            Log Many                     IR List: @{IR_list}
            List Should Contain Value    ${IR_list}    ${ice_rink_name}
    END

    Log Many                        IR List: @{IR_list}
    ${list_length} =                Get Length    ${IR_list}
    Log                             List length: ${list_length}
    Should Be Equal As Integers     ${count_of_ice_rinks}    ${list_length}
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