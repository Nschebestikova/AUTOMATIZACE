*** Settings ***
Library  Browser

Resource  Configuration.robot
Resource  TestData.robot

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}
Test Setup      Before test execution
Test Teardown   After test executon

*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Test Cases ***
Login - OK
    Login with check           ${USER1_EMAIL}    ${USER1_PASSWORD}       Passed

Login - NOK - invalid password
    Login with check           ${USER1_EMAIL}    ${INVALID_PASSWORD}     Failed login

Login - NOK - invalid email
     Login with check          ${INVALID_EMAIL}   ${USER1_PASSWORD}      Failed login

Logout - OK
     Login with check          ${USER1_EMAIL}    ${USER1_PASSWORD}       Passed
     Logout with check

Course Registration - OK
     Login with check          ${USER1_EMAIL}    ${USER1_PASSWORD}       Passed
     Registration with check   ${ICO}            ${PHONE}

*** Keywords ***
Login with check
   [Arguments]                 ${USER1_EMAIL}    ${USER1_PASSWORD}       ${text}
   New Page                    ${URL}
   Get Title  ==               ${TEXT_MainTitle}

   Click                       ${SEL_LoginLink}
   Type Text                   ${SEL_LoginFormEmail}     ${USER1_EMAIL}
   Type Text                   ${SEL_LoginFormPwd}       ${USER1_PASSWORD}
   Click                       ${SEL_UserLoginBtn}
   Take Screenshot

        IF    "${text}" == "Passed"
      Get Text     ${SEL_UserLogoutBtn}   ==            ${TEXT_Ohlasit}
  ELSE IF     "${text}" == "Failed login"
      Get Text     ${SEL_LoginLink}       ==            ${TEXT_Prihlasit}
  ELSE
      Get Text     ${SEL_LoginLink}       ==            ${TEXT_Prihlasit}
  END


Logout with check
     Click                    ${SEL_UserLogoutBtn}
     Get Text                 ${SEL_LoginLink}             ==         ${TEXT_Prihlasit}

Registration with check
     [Arguments]              ${ICO}          ${PHONE}
     Set Strict Mode          off
     Click                    ${SEL_UserRegistrLink}
     Get text                 ${SEL_RegistrCourseName}     ==       ${TEXT_CourseName}
     Click                    ${SEL_UserRegistrLink}
     Get text                 ${SEL_CourseRegistrTitle}    ==       ${TEXT_Registration}
     Click                    ${SEL_UserICO}
     Type Text                ${SEL_UserICO}                        ${ICO}
     Click                    ${SEL_UserPhone}
     Type Text                ${SEL_UserPhone}                      ${PHONE}
     Click                    ${SEL_UserRegistrLink}
     Get Text                 ${SEL_CourseTitle}           ==       ${TEXT_MyCourses}

Error Invalid password
       Get Text              ${SEL_LoginErrorTxt}          *=      ${ERROR_TEXT_IncorrectEmailOrPwd}
       Take Screenshot

Error Invalid email
       Get Text              ${SEL_LoginIncorrectEmail}    *=      ${ERROR_TEXT_IncorrectEmailOrPwd}
       Take Screenshot

Before test execution
       New Browser           headless=False
       New Page              ${URL}

After test executon
      Close Browser