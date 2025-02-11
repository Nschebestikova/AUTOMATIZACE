*** Variables ***

# strings
${TEXT_TITLE}                       Testování - Přehled kurzů
${TEXT_LOGIN}                       Přihlásit se
${TEXT_LOGOUT}                      Odhlásit se
${TEXT_LOGGED_IN}                   Logged In
${TEXT_NOT_LOGGED_IN}               Not Logged In
${TEXT_EMPTY_EMAIL}                 data-test=email_input_errors
${TEXT_EMPTY_PASSWORD}              id=password_input_errors

# user Login
${CORRECT_USER_EMAIL}               giyipem264@v1zw.com
${CORRECT_USER_PASSWORD}            tajnenovak
${BAD_USER_EMAIL}                   peternovak@gmail.com
${BAD_USER_PASSWORD}                tajneheslo

# admin login
${ADMIN_EMAIL}                      lector@lector.com
${ADMIN_PASSWORD}                   lector@lector.com

# admin check
${COURSE_NAME}                      css=.course_3 >> [data-test=registration_link]
${SEL_USER_LOGGED_LINK}             #data-test=registration_link
${NAME_USER}                        Michal Novák

# login selectors
${SEL_LOGIN}                        data-test=login_link
${SEL_EMAIL_INPUT}                  data-test=email_input
${SEL_PASSWORD_INPUT}               data-test=password_input
${SEL_SUBMIT}                       data-test=login_button
${SEL_LOGOUT}                       data-test=logout_button

# registration selectors
${SEL_IC_LINK}                      id=ico
${SEL_TELEFON_LINK}                 id=phone
${SEL_COURSE_LINK}                  data-test=registration_link
${SEL_REGISTRATION_LINK}            data-test=registration_link
${SEL_SUBMIT_REGISTRATION_LINK}     data-test=registration_link
${SEL_COURSE_NAME}                  data-test=course_name
${SEL_ICO_ERROR}                    data-test=ico_error
${SEL_PHONE_ERROR}                  data-test=phone_error

# registration strings
${TEXT_COURSE_NAME}                 Jak ovládat GIT 2
${TEXT_REGISTRATION_TITLE}          data-test=registration_title
${TEXT_ICO}                         31576753
${TEXT_TELEFON}                     123456789
${TEXT_ICO_ERROR}                   Neplatné IČO
${TEXT_PHONE_ERROR}                 Telefonní číslo musí obsahovat alespoň 9 číslic.