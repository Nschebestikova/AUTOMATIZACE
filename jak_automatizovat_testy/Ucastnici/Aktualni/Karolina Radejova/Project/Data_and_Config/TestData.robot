# Test data

*** Variables ***

# user data
${USER_NAME}                                name surname                                        #general user
${USER_EMAIL}                               user1@user1.com                                     #user for registration
${USER_EMAIL_registration}                  user67@user.com                                     #not registered email for positive registration TC - registration test suite
${USER_EMAIL_registration2}                 user68@user.com                                     #not registered email for positive registration TC - courses test suite
${USER_EMAIL_registration3}                 user59@user.com                                     #not registered email for negative registration TC - short password, wrong password verification
${USER_PASSWORD}                            somethingclever
${USER_PHONE}                               777123456
${USER_ICO}                                 25596641
${LECTOR_EMAIL}                             lector@lector.com
${LECTOR_PASSWORD}                          lector@lector.com

#course data
${COURSE_capacity}                          12
${COURSE_iteration_empty_course}            5
${COURSE_iteration_full_course}             1
${COURSE_iteration}                         1
${COURSE_number}                            1

#new course data
${COURSE_ADD_name}                          Python 2
${COURSE_ADD_description}                   Naučte se během několika večerů základy jazyka Python. Kurz navazuje na kurz Python 1.
${COURSE_ADD_capacity}                      10
${COURSE_ADD_price}                         4700

# strings
${TEXT_prihlasit_se}                        Přihlásit se
${TEXT_odhlasit_se}                         Odhlásit se
${TEXT_reset_password}                      We have emailed your password reset link.
${TEXT_welcome_user}                        Vítej uživateli
${TEXT_course_page_title}                   Testování - Přehled kurzů
${TEXT_courses_interest}                    Máte zájem o naše kurzy?
${TEXT_course_registration_page}            Registrace kurzu

# error messages
${ERROR_MSG_wrong_credentials}              These credentials do not match our records.
${ERROR_MSG_taken_email}                    The email has already been taken.
${ERROR_MSG_short_password}                 The password field must be at least 8 characters.
${ERROR_MSG_password_confirmation}          The password field confirmation does not match.
${ERROR_MSG_email_does_not_exist}           We can't find a user with that email address.
${ERROR_MSG_already_taken_email}            The email has already been taken.
${ERROR_MSG_short_password}                 The password field must be at least 8 characters.
${ERROR_MSG_password_confirmation}          The password field confirmation does not match.
${ERROR_MSG_wrong_ico}                      Neplatné IČO
${ERROR_MSG_wrong_phone}                    Telefonní číslo musí obsahovat alespoň 9 číslic.

# selectors
#login, registration
${SEL_login_link}                           data-test=login_link                                #link Přihlásit se v Navigation menu
${SEL_login_link_register_page}             xpath=//*[contains(text(),'Přihlašte se zde.')]     #login link in registration page
${SEL_logout_button}                        data-test=logout_button                             #link Odhlásit se v Navigation menu
${SEL_email_input}                          data-test=email_input
${SEL_password_input}                       data-test=password_input
${SEL_password_verification}                data-test=password_again_input
${SEL_login_button}                         data-test=login_button                              #button Přihlásit se in /login page
${SEL_email_input_errors}                   data-test=email_input_errors                        #wrong credentials
${SEL_reset_password_text}                  xpath=//div[@data-test='status_div']
${SEL_forgot_password_link}                 xpath=//a[@id='forgot_password_link']|//a[@href='/forgot_password']
${SEL_submit_button}                        data-test=submit_button
${SEL_register_link}                        data-test=register_link
${SEL_name_input}                           data-test=name_input
${SEL_register_button}                      data-test=register_button                           #submit button in /forgot-password page
${SEL_home_section}                         data-test=home_section                              #home section is displayed after registration or after click to Domů in Navigation menu
${SEL_email_taken}                          data-test=email_input_errors                        #email already taken in registration form
${SEL_password_wrong_confirmation}          data-test=password_input_errors                     #passwords do not match
${SEL_short_password}                       data-test=password_input_errors                     #too short password

#courses selectors
${SEL_courses_link}                         data-test=courses_link                              #link to courses page in Navigation menu
${SEL_courses_interest_title}               data-test=interest_title                            #user is not logged in
${SEL_course_name}                          data-test=course_name
${SEL_course_description}                   data-test=course_description
${SEL_course_price}                         data-test=course_price
${SEL_course_image}                         data-test=course_image
${SEL_course_capacity}                      data-test=course_capacity
${SEL_course_button}                        data-test=course_buttons                            #button to view course detail page
${SEL_course_button_view_more}              css=[data-test=course_${COURSE_number}] [data-test=registration_link]
${SEL_course_page_register_link}            data-test=registration_link
${SEL_course_register_to_course_title}      data-test=registration_title                        #title displayed on registration page of course
${SEL_course_ico_input}                     data-test=ico_input
${SEL_course_phone_input}                   data-test=phone_input
${SEL_registered_courses}                   xpath=//a[text()='Moje kurzy']                      #registered courses link in Navigation menu
${SEL_course_my_course}                     data-test=course_${COURSE_number}                   #course displayed in My courses page
${SEL_courses_list}                         xpath=//a[text()='Přehled kurzů']                   #courses list link in Navigation menu
${SEL_ico_error}                            data-test=ico_error
${SEL_phone_error}                          data-test=phone_error
${SEL_course_icon}                          xpath=//*[contains(@alt,'Course icon')]             #course icon is displayed in course detail page
${SEL_course_detail_capacity}               css=[data-test='iteration_${COURSE_iteration}'] p:nth-child(3)      #capacity of selected course detail page
${SEL_course_detail_register_link}          [data-test=iteration_${COURSE_iteration}] [data-test=registration_link]     #registration button of displayed detail of course
${SEL_course_title}                         data-test=courses_title                             #title in courses page
${SEL_course_add_new_course}                xpath=//*[text()='Přidat kurz']
${SEL_course_add_name}                      data-test=course_name_input
${SEL_course_add_description}               data-test=course_description_input
${SEL_course_add_capacity}                  data-test=course_capacity_input
${SEL_course_add_price}                     data-test=course_price_input
${SEL_course_add_button_create}             data-test=registration_link                                                 #button create new course

#${SEL_course_add_iteration}                 xpath=//button[text()='Přidat iteraci']
#${SEL_course_start_input}                   data-test=course_start_input
#${SEL_course_end_input}                     data-test=course_end_input
#${SEL_course_day_select}                    data-test=course_day_select
#${SEL_course_selected_day}                  xpath=//*[text()='${ADD_COURSE_selected_day}']

