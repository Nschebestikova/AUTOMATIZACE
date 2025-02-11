*** Settings ***
Library  Browser

Resource             TestData_Projekt.robot
Resource             Configuration.robot

Test Setup           Pred_testem

*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Test Cases ***
Login - Uspesne prihlaseni
   Login_s_kontrolou           ${USER_EMAIL}                    ${USER_PASSWORD}            prihlasi se
   Log_out_s_kontrolou

Login - Chybne prihlaseni- chybne heslo
   Login_s_kontrolou           ${USER_EMAIL}                    ${TEXT_chybneHeslo}         neprihlasi se

Login - Chybne prihlaseni- neexistujíci jmeno
   Login_s_kontrolou           ${TEXT_chybnyEmail}              ${USER_PASSWORD}            neprihlasi se

Logout - uspesne odhlaseni
   Login_s_kontrolou           ${USER_EMAIL}                    ${USER_PASSWORD}            odhlasi se
   Log_out_s_kontrolou

Registrace na kurz - úspesna registrace
   Login_s_kontrolou           ${USER_EMAIL}                    ${USER_PASSWORD}            prihlasi se
   Registrace_s_kontrolou       ${TEXT_ICO}                     ${TEXT_Phone}
   Log_out_s_kontrolou
   #nefunkční scénář, jelikož není již tlačítko nezávazná registrace- kurzy jsou obsazeny

*** Keywords ***
Login_s_kontrolou
  [Arguments]        ${Email}            ${Heslo}              ${Text}
  Get Title  ==      ${TEXT_MainTitle}
  Click            ${SEL_LoginLink}
  Type Text        ${SEL_LoginFormEmail}            ${Email}
  Type Text        ${SEL_LoginFormPwd}              ${Heslo}
  Click            ${SEL_UserLoginBtn}

  IF    "${Text}" == "prihlasi se"
      Get Text     ${SEL_UserLogoutBtn}        ==            ${TEXT_Ohlasit}
  ELSE IF    "${Text}" == "neprihlasi se"
      Get Text     ${SEL_LoginLink}      ==            ${TEXT_Prihlasit}
  ELSE
      Get Text     ${SEL_LoginLink}        ==            ${TEXT_Prihlasit}
  END

Logout_s_kontrolou
  Click             ${SEL_UserLogoutBtn}
  Get Text          ${SEL_LoginLink}                    ==    ${TEXT_Prihlasit}

Registrace_s_kontrolou
    [Arguments]                ${ICO-Text}              ${TELEFON-Text}
  Set Strict Mode    off
  Click             ${SEL_UserRegistrLink}
  Click             ${SEL_UserRegistrLink}
  Get Text          ${SEL_UserRegistrBtn}                    ==            ${TEXT_Registrace}
  Click             ${SEL_UserRegistrLink}
  Click             ${SEL_UserICO}
  Type Text         ${SEL_UserICO}                       ${ICO-Text}
  Click             ${SEL_UserPhone}
  Type Text         ${SEL_UserPhone}                     ${TELEFON-Text}
  Click             ${SEL_UserRegistrLink}
  Get Text          ${SEL_UserCourseTitle}                  ==             ${TEXT_MeKurzy}

Pred_testem
        New Browser        headless=False
        New Page            ${URL}


