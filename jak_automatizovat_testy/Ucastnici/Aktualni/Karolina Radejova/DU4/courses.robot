*** Settings ***
Library     Browser
Library     OperatingSystem

Resource    ../Project/Data_and_Config/TestData.robot
Resource    ../Project/Data_and_Config/Configuration.robot

Suite Setup     Before_suite
Suite Teardown  After_suite

Test Setup      Before_test
Test Teardown   After_test

*** Variables ***

*** Test Cases ***
Check count of displayed courses
    List of courses

List of course name and prices
    Prices of course
    
Check the course image, name, capacity, price, button Chci vědět více are visible
    Check the courses section contains visible name, capacity, price, button Chci vědět více

# login -> registration to course
User is logged and registered to course, control of course in page Moje kurzy
    Login with control of button login/logout text          ${USER_EMAIL}    ${USER_PASSWORD}      log in
    Registration for course                                 25596641         ${USER_PHONE}
    Check the registered course in page Moje kurzy

User is not registered to course - wrong ICO
    Login with control of button login/logout text          ${USER_EMAIL}    ${USER_PASSWORD}      log in
    Registration for course                                 25596649456      ${USER_PHONE}
    Wrong ICO

User is not registered to course - wrong phone
    Login with control of button login/logout text          ${USER_EMAIL}    ${USER_PASSWORD}      log in
    Registration for course                                 ${USER_ICO}      777123
    Wrong phone

#registration to course -> registration of user
User makes successfull registration via course page and registers to course
    User opens registration form via course page
    Fill and send registration form     ${USER_NAME}    ${USER_EMAIL_registration2}    ${USER_PASSWORD}    ${USER_PASSWORD}    registered
    Click                               ${SEL_courses_link}
    Registration for course             ${USER_ICO}    ${USER_PHONE}
    Check the registered course in page Moje kurzy

#registration to course -> login
User logges in via course page and registered to course
    User logs in via course page
    Login with control of button login/logout text          ${USER_EMAIL}    ${USER_PASSWORD}      log in
    Registration for course                                 ${USER_ICO}      ${USER_PHONE}
    Check the registered course in page Moje kurzy

#check the course is full - not general solution
User can not register to full course
    Login with control of button login/logout text      ${USER_EMAIL}               ${USER_PASSWORD}                    log in
    Full course                                         ${COURSE_capacity}          ${COURSE_iteration_full_course}     ${COURSE_number}

#check the course is full - general solution
Course register button is not displayed - course is full
    Login with control of button login/logout text      ${USER_EMAIL}               ${USER_PASSWORD}                    log in
    Check the course is full                            ${COURSE_capacity}          ${COURSE_iteration_full_course}     ${COURSE_number}            not visible

Course register button is displayed - course is not full
    Login with control of button login/logout text      ${USER_EMAIL}               ${USER_PASSWORD}                    log in
    Check the course is full                            ${COURSE_capacity}          ${COURSE_iteration_empty_course}    ${COURSE_number}            visible

Check the correct strings are displayed in new added course
    New course                                          ${COURSE_ADD_name}          ${COURSE_ADD_description}           ${COURSE_ADD_capacity}      ${COURSE_ADD_price}

*** Keywords ***

# postup:
#for cyklus, ktery do promenne pres Get Text uklada texty daneho kurzu, v posledni iteraci se do promennych ulozi stringy z nove pridaneho kurzu

New course
    [Arguments]     ${input_name}   ${input_description}     ${input_capacity}      ${input_price}
    Login with control of button login/logout text    ${LECTOR_EMAIL}    ${LECTOR_PASSWORD}    log in
    Get Url                     *=  ${URL_courses}
    Log                         ${URL_courses} page is displayed
    Click                       ${SEL_course_add_new_course}
    Get Url                     *=  ${URL_course_create}
    Log                         ${URL_course_create} page is displayed
    Type Text                   ${SEL_course_add_name}              ${input_name}           #${COURSE_ADD_name}
    Log                         ${input_name}
    Type Text                   ${SEL_course_add_description}       ${input_description}    #${COURSE_ADD_description}
    Log                         ${input_description}
    Type Text                   ${SEL_course_add_capacity}          ${input_capacity}       #${COURSE_ADD_capacity}
    Log                         ${input_capacity}
    Type Text                   ${SEL_course_add_price}             ${input_price}          #${COURSE_ADD_price}
    Log                         ${input_price}
    Click                       ${SEL_course_add_button_create}
    Log                         New course was created
    Click                       ${SEL_logout_button}
    Log                         ${LECTOR_EMAIL} was logged out
    Login with control of button login/logout text    ${USER_EMAIL}    ${USER_PASSWORD}    log in
    Log                         ${USER_EMAIL} is logged in
    Get Url         *=          ${URL_courses}
    ${count_courses} =          Get Element Count           ${SEL_course_name}
    Log                         ${count_courses}

   FOR    ${counter}    IN RANGE        ${count_courses}
      ${displayed_course_name} =            Get Text    ${SEL_course_name} >> nth=${counter}
      ${displayed_course_description} =     Get Text    ${SEL_course_description} >> nth=${counter}
      ${displayed_course_capacity} =        Get Text    ${SEL_course_capacity} >> nth=${counter}
      ${displayed_course_price} =           Get Text    ${SEL_course_price} >> nth=${counter}
   END

    Should Be Equal    ${input_name}                      ${displayed_course_name}
    Log                ${input_name}, ${displayed_course_name}
    Should Be Equal    ${input_description}               ${displayed_course_description}
    Log                ${input_description}, ${displayed_course_description}
    Should Be Equal    Kapacita: ${input_capacity}        ${displayed_course_capacity}
    Log                Kapacita: ${input_capacity}, ${displayed_course_capacity}
    Should Be Equal    Cena: ${input_price} Kč            ${displayed_course_price}
    Log                Cena: ${input_price} Kč, ${displayed_course_price}


List of courses
    #count of courses
    ${count_of_courses} =   Get Element Count    ${SEL_course_name}
    Log                     Count of courses: ${count_of_courses}


    #log names of courses
    FOR    ${course_count}    IN RANGE    ${count_of_courses}

        ${course_name} =    Get Text    ${SEL_course_name} >> nth=${course_count}
        Log                             Name of course: ${course_name}
    END

Prices of course
    List of courses
    #count of courses
    ${count_of_courses} =   Get Element Count    ${SEL_course_name}
    Log                     Count of courses: ${count_of_courses}


    #log names of courses
    FOR    ${course_count}    IN RANGE    ${count_of_courses}

        ${course_name} =    Get Text    ${SEL_course_name} >> nth=${course_count}
        ${course_price} =   Get Text    ${SEL_course_price} >> nth=${course_count}
        Log                             Name of course: ${course_name}, ${course_price}
    END

Check the courses section contains visible name, capacity, price, button Chci vědět více
    ${count_of_courses} =   Get Element Count    ${SEL_course_name}
    Log                     Count of courses: ${count_of_courses}
    FOR    ${count}    IN RANGE    ${count_of_courses}
        Get Element States    ${SEL_course_image}        *=      visible
        Get Element States    ${SEL_course_name}         *=      visible
        Get Element States    ${SEL_course_capacity}     *=      visible
        Get Element States    ${SEL_course_price}        *=      visible
        Get Element States    ${SEL_course_button}       *=      visible
        Log                   Image, name, capacity, price, buttons are visible

    END

User opens registration form via course page
    Click               ${SEL_course_button_view_more}
    ${course_name} =    Get Text    ${SEL_course_name}
    Click               ${SEL_course_page_register_link}
    Get Url        *=   ${URL_register}
    Log                 ${URL_register} page opened
    Take Screenshot

User logs in via course page
    Click               ${SEL_course_button_view_more}
    ${course_name} =    Get Text    ${SEL_course_name}
    Click               ${SEL_course_page_register_link}
    Get Url        *=   ${URL_register}
    Log                 ${URL_register} page opened
    Click               ${SEL_login_link_register_page}
    Get Url        *=   ${URL_login}
    Log                 ${URL_login} page opened


Registration for course
    [Arguments]         ${ico}     ${phone}
    Click               ${SEL_course_button_view_more}
    ${course_name} =    Get Text    ${SEL_course_name}
    Click               ${SEL_course_page_register_link}
    Get Text            ${SEL_course_register_to_course_title}  ==  ${TEXT_course_registration_page}
    Type Text           ${SEL_course_ico_input}     ${ico}
    Type Text           ${SEL_course_phone_input}   ${phone}
    Click               ${SEL_course_page_register_link}
    Log                 User was registered to course: ${course_name}
    Take Screenshot

Check the registered course in page Moje kurzy
    Click               ${SEL_registered_courses}
    Take Screenshot
    Get Url             *=   ${URL_my_courses}
    ${course_name} =    Get Text    ${SEL_course_my_course}
    Log                 Page ${URL_my_courses} contains ${course_name}

Wrong ICO
    Get Text    ${SEL_ico_error}         ==      ${ERROR_MSG_wrong_ico}
    Take Screenshot
    Log         Wrong ICO is filled

Wrong phone
    Get Text    ${SEL_phone_error}      ==      ${ERROR_MSG_wrong_phone}
    Take Screenshot
    Log         Phone is too short

Login with control of button login/logout text
    [Arguments]     ${email}    ${password}     ${should_be_logged_in}
    Login without control of button login/logout text    ${email}    ${password}

    IF    "${should_be_logged_in}" == "log in"
        Get Text    ${SEL_logoutButton}     ==      ${TEXT_odhlasit_se}
    ELSE
         Get Text   ${SEL_loginLink}        ==      ${TEXT_prihlasit_se}
    END

    Take Screenshot

Login without control of button login/logout text
    [Arguments]     ${email}     ${password}

    Click           ${SEL_loginLink}
    Log             Button was clicked
    Get Url     *=  ${URL_login}
    Log             Url contains "${URL_login}"
    Type Text       ${SEL_email_input}        ${email}
    Log             ${email} is filled
    Type Text       ${SEL_password_input}     ${password}
    Log             ${password} is filled
    Click           ${SEL_login_button}
    Log             Login button was clicked

Logout with control of button login/logout text
    [Arguments]     ${email}        ${password}     ${should_be_logged_out}
    Login without control of button login/logout text    ${email}    ${password}

    IF    "${should_be_logged_out}" == "log out"
        Click       ${SEL_logoutButton}
        Get Text    ${SEL_loginLink}        ==      ${TEXT_prihlasit_se}
    ELSE
         Get Text   ${SEL_logoutButton}     ==      ${TEXT_odhlasit_se}
    END

    Take Screenshot

Wrong credentials - error message
    Get Text                    ${SEL_email_input_errors}        ==      ${ERROR_MSG_wrong_credentials}
    Log                         ${ERROR_MSG_wrong_credentials} message is displayed
    Take Screenshot

Fill and send registration form
    [Arguments]     ${name}     ${email}    ${password}     ${password_verification}    ${should_be_registered}
    Log             ${name}
    Log             ${email}
    Log             ${password}

    Click           ${SEL_login_link}
    Log             Button was clicked
    Get Url         *=  ${URL_login}
    Log             Url contains "${URL_login}"
    Click           ${SEL_register_link}
    Get Url         *=  ${URL_register}
    Log             ${URL_register} page is opened
    Fill Text       ${SEL_name_input}                   ${name}
    Log             Name is filled
    Fill Text       ${SEL_email_input}                  ${email}
    Log             Email is filled
    Fill Text       ${SEL_password_input}               ${password}
    Log             Password is filled
    Fill Text       ${SEL_password_verification}        ${password_verification}
    Log             Password again is filled
    Click           ${SEL_register_button}
    Log             Register button was clicked

    IF    "${should_be_registered}" == "not registered"
        Get Url     *=      ${URL_register}
        Take Screenshot
    ELSE
        Get Text    ${SEL_home_section}     ==      ${TEXT_welcome_user} ${name}!
        Log         Home page with ${TEXT_welcome_user} is displayed
        Take Screenshot
    END

 Email has already taken
    Get Text    ${SEL_email_taken}      ==      ${ERROR_MSG_already_taken_email}
    Log         ${ERROR_MSG_already_taken_email} message is displayed
    Take Screenshot

 Password has to be 8 characters long
    Get Text    ${SEL_short_password}        ==      ${ERROR_MSG_short_password}
    Log         ${ERROR_MSG_short_password} message is displayed
    Take Screenshot

 Password field confirmation does not match
    Get Text    ${SEL_password_wrong_confirmation}        ==      ${ERROR_MSG_password_confirmation}
    Log         ${ERROR_MSG_password_confirmation} message is displayed
    Take Screenshot

#full course - not general solution
Full course
    [Arguments]     ${course_capacity}      ${iteration_number}     ${course_number}
    Click                       ${SEL_course_button_view_more}
    Wait For Elements State     ${SEL_course_icon}      visible
    Take Screenshot
    ${kapacita} =   Get Text    ${SEL_course_detail_capacity}
    Log                         ${kapacita}
    IF      "${kapacita}" == "Kapacita: ${COURSE_capacity}/${COURSE_capacity}"
            Get Element States    ${SEL_course_detail_register_link}    !=   visible
    END

#full course - general solution
Check the course is full
    [Arguments]     ${course_capacity}      ${iteration_number}     ${course_number}     ${btn_register_visibility}
    Click                       ${SEL_course_button_view_more}
    Wait For Elements State     ${SEL_course_icon}      visible
    Take Screenshot
    ${kapacita} =   Get Text    ${SEL_course_detail_capacity}
    Log                         ${kapacita}
    IF      "${kapacita}" == "Kapacita: ${COURSE_capacity}/${COURSE_capacity}" and "${btn_register_visibility}" == "not visible"
            Get Element States    [data-test=iteration_${iteration_number}] [data-test=registration_link]    !=   visible
            Log    Course capacity is full, register button is not visible
    ELSE
            Get Element States    [data-test=iteration_${iteration_number}] [data-test=registration_link]    *=   visible
            Log    Course capacity is not full, register button is visible
    END

Before_suite
   New Browser              chromium   headless=False
   Sleep                    ${SLEEP_BEFORE_TEST}

Before_test
#   New Browser              chromium   headless=False
   New Page                 ${URL}
   Set Browser Timeout      ${TimeOut_Browser}
   Sleep                    ${SLEEP_BEFORE_TEST}
   Get Text                 ${SEL_courses_interest_title}        ==      ${TEXT_courses_interest}
   Log                      Page with courses was loaded
   Set Strict Mode          off

After_test
    Go To                   ${URL}

After_suite
    Close Browser