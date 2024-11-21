*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Test Cases ***
Login - Uspesne prihlaseni
   Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak          prihlasi se

Login - Chybne prihlaseni- chybne heslo
   Login_s_kontrolou           giyipem264@v1zw.com                  chyba              neprihlasi se

Login - Chybne prihlaseni- neexistujíci jmeno
   Login_s_kontrolou           ggggg@gmail.com                     tajnenovak         neprihlasi se

Logout - uspesne odhlaseni
   Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak          odhlasi se
   Log_out_s_kontrolou

Registrace na kurz - úspesna registrace
   Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak          prihlasi se
   Registrace_s_kontrolou       70252017                            733314663

*** Keywords ***
Login_s_kontrolou
  [Arguments]        ${Email}            ${Heslo}         ${Text}
  New Browser        headless=False
  New Page           ${URL}
  Get Title  ==      Testování - Přehled kurzů

  Click            data-test=login_link
  Type Text        data-test=email_input            ${Email}
  Type Text        data-test=password_input         ${Heslo}
  Click            data-test=login_button

  IF    "${Text}" == "prihlasi se"
      Get Text     data-test=logout_button       ==            Odhlásit se
  ELSE IF    "${Text}" == "neprihlasi se"
      Get Text     data-test=login_link      ==            Přihlásit se
  ELSE
      Get Text     data-test=login_link        ==            Přihlásit se
  END

Logout_s_kontrolou
  Click             data-test=logout_button
  Get Text          data-test=login_link

Registrace_s_kontrolou
    [Arguments]                ${ICO-Text}    ${TELEFON-Text}
  Set Strict Mode    off
  Click             data-test=registration_link
  Click             data-test=registration_link
  Get Text          data-testid=registration_title          ==            Registrace kurzu
  Click             data-test=registration_link
  Click             data-testid=ico_input
  Type Text         data-testid=ico_input      ${ICO-Text}
  Click             data-testid=phone_input
  Type Text         data-testid=phone_input    ${TELEFON-Text}
  Click             data-testid=registration_link
  Get Text          data-testid=courses_title               ==            Mé zapsané kurzy


# DATA:
#     ${USER1_NAME}         Michal Novák
#     ${USER1_EMAIL}         giyipem264@v1zw.com
#     ${USER1_password}        tajnenovak

