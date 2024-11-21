*** Settings ***
Library  Browser

*** Variables ***
${USER1_NAME}               Michal Novák
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak
${URL}                      http://testovani.kitner.cz/login
${INVALID_PASSWORD}         password
${INVALID_EMAIL}            test@test.com
${ICO}                      10669990
${PHONE}                    775056071

*** Test Cases ***
Login - OK
    Login with check     ${USER1_EMAIL}    ${USER1_PASSWORD}       Passed

Login - NOK - invalid password
    Login with check     ${USER1_EMAIL}    ${INVALID_PASSWORD}     Failed login

Login - NOK - invalid email
     Login with check    ${INVALID_EMAIL}   ${USER1_PASSWORD}      Failed login

Logout - OK
     Login with check    ${USER1_EMAIL}    ${USER1_PASSWORD}       Passed
     Logout with check

Course Registration - OK
     Login with check    ${USER1_EMAIL}    ${USER1_PASSWORD}       Passed
     Registration with check   ${ICO}         ${PHONE}             Passed


*** Keywords ***
Login with check
     [Arguments]         ${USER1_EMAIL}    ${USER1_PASSWORD}      ${text}
     New Browser         chromium   headless=false
     New Page            ${URL}
     Get Title           contains    Testování

     Type Text           data-test=email_input                    ${USER1_EMAIL}
     Type Text           data-test=password_input                 ${USER1_PASSWORD}
     Click               data-test=login_button
     Get text            data-test=login_link
     Take Screenshot

      IF    "${text}" == "Passed"
      Get Text     data-test=logout_button       ==            Odhlásit se
  ELSE IF    "${text}" == "Failed login"
      Get Text     data-test=login_link      ==            Přihlásit se
  ELSE
      Get Text     data-test=login_link        ==            Přihlásit se
  END

Logout with check
     Click                data-test=logout_button
     Get Text             data-test=login_link              ==          Přihlásit se

Registration with check
     [Arguments]         ${ICO}          ${PHONE}                 ${text}
     Set Strict Mode     off
     Click               data-test=registration_link
     Get text            data-test=course_name            ==       Jak ovládat GIT
     Click               data-test=registration_link
     Get text            data-test=registration_title     ==       Registrace kurzů
     Click               data-test=ico_input
     Type Text           data-test=ico_input                      ${ICO}
     Click               data-test=phone_input
     Type Text           data-test=phone_input                    ${PHONE}
     Click               data-test=registration_link
     Get Text            data-test=course_title           ==       Mé zapsané kurzy
     Take Screenshot
