# požadavky:
#   pip install robotframework-browser
#   rfbrowser init

*** Settings ***
Documentation   CV: Testovaci data - pripravit ciselnik chybovych hlasek
Library         Browser

#Resource  C:/Test/jak_automatizovat_testy/Cviceni/Data_and_Config/TestData.robot  # absolutní  cesta, pozor na lomítka fungují jen normální, nefungují windows
Resource  Data_and_Config/TestData.robot                                          # releativní cesta



*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

Login - Uspesne prihlaseni
    Login                       ${USER1_EMAIL}                       ${USER1_PASSWORD}
    Uživatel je přihlášen

Login - Chybne heslo
    Login                       ${USER1_EMAIL}                       chyba
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje

Login - Chybne jméno
    Login                       blbe@neco.cz                         ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje


Login - Prazdne heslo
    Login                       ${USER1_EMAIL}                       ${EMPTY}
    Uživatel není přihlášen
    Chybova hlaska prazdne heslo

Login - Prazdny email
    Login                       ${EMPTY}                             ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska prazdny email

*** Keywords ***
Login
   [Arguments]          ${Email}            ${Heslo}

   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      ${TEXT_MainTitle}

   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}
   Type Text        data-test=password_input         ${Heslo}
   Click            data-test=login_button
   Take Screenshot

Uživatel je přihlášen
    Get Text        data-test=logout_button       ==       ${TEXT_Ohlasit}
    Take Screenshot


Uživatel není přihlášen
    Get Text        data-test=login_link          ==       ${TEXT_Prihlasit}
    Take Screenshot


Chybova hlaska neplatne udaje
       Get Text   data-test=email_input_errors      *=  ${ERROR_TEXT_IncorrectEmailOrPwd}   # AssertNeg1
       Take Screenshot

Chybova hlaska prazdny email
       Get Text   data-test=email_input_errors      *=  ${ERROR_TEXT_EmptyEmail}
       Take Screenshot

Chybova hlaska prazdne heslo
       Get Text   data-test=password_input_errors   *=  ${ERROR_TEXT_EmptyPwd}
       Take Screenshot
