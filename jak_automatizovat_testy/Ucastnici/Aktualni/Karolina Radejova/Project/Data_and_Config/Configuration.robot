#*** Variables ***
# Tento soubor obsahuje všechny konfigurační parametry a proměnné
#

*** Variables ***
${URL}                          http://testovani.kitner.cz/courses
${URL_courses}                  kitner.cz/courses
${URL_login}                    kitner.cz/login
${URL_forgot_password}          kitner.cz/forgot-password
${URL_register}                 kitner.cz/register
${URL_my_courses}               kitner.cz/my-courses
${URL_course_create}            kitner.cz/courses/create

${BROWSER} =                    chromium

${PORT}                         80

${TIME_BETWEEN_CLICKS}          50ms
${TIME_BETWEEN_CHECKS}          100ms

${SLEEP_BEFORE_TEST}            1s

${TIMEOUT_BROWSER}              18 s
${TC_TIMEOUT_ROBOT_KW}          2 minutes
