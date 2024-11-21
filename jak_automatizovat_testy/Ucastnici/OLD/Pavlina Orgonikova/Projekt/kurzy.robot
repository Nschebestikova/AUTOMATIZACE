*** Settings ***
Library            Browser     timeout=30s
Resource           Data/TestData.robot
Resource           Data/Configuration.robot

Suite Setup        Pred_sadou
Suite Teardown     Po_sade_uklid

Test Setup         Pred_testem
Test Teardown      Po_testu_uklid

Test Timeout       ${TEST_TIMEOUT}

*** Variables ***
#jsou v TestData.robot a Configuration.robot souborech

*** Test Cases ***

Jake kurzy jsou v nabídce
   # New Browser         headless=False
   # Otevření stránky    ${URL}
   Seznam kurzu        ${URL}

#PRIHLASENI VARIANTY
Přihlášení špatný email i heslo - s kontrolou
    Login_s_kontrolou      nesmysl@ale.cz         nevim     ne
    Chybova Hlaska Neplatne Udaje
    
Přihlášení špatné heslo - s kontrolou
    Login_s_kontrolou      ${SEL_LoginEmail}   zapomnelajsem   ne
    Chybova Hlaska Neplatne Udaje
    
Přihlášení prázdný email - s kontrolou
    Login_s_kontrolou       ${EMPTY}          ${SEL_LoginPassword}     ne
    Chybova Hlaska Prazdny Email
    
Přihlášení prázdné heslo - s kontrolou
    Login_s_kontrolou       ${SEL_LoginEmail}      ${EMPTY}       ne
    Chybova Hlaska Prazdne Heslo

Přihlášení úspěšné - s kontrolou
    Login_s_kontrolou       ${SEL_LoginEmail}      ${SEL_LoginPassword}   ano
    Logout

#PROKLIK REGISTRACE NA KURZ
Proklik na registraci na kurz - uzivatel neprihlasen
    Registrace_do_kurzu     ${URL}

#tento test neprochází, protože chybí proklik na registraci do kurzu v případě již přihlášeného uživatele
Proklik na registraci na kurz - uzivatel prihlasen
    Login_s_kontrolou     ${SEL_LoginEmail}      ${SEL_LoginPassword}   ano
    Registrace_do_kurzu     ${URL}
    




*** Keywords ***

Pred_sadou
   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      ${TEXT_MainTitle}

Pred_testem
   ${timeout} =       Set Browser Timeout        ${TIMEOUT_BROWSER}
   Go To              ${URL}

Po_testu_uklid
   Log                Uklid po testu.
   Go To              ${URL}
#odhlášení v případě přihlášeného uživatele:
   ${menu} =   Get Text    ${SEL_Menu}
   Log to Console  ${menu}
   IF  "Odhlásit se" in "$menu"   #OTAZKA: když jsem použila IF "Odhlásit se" in "${menu}", házelo to error. proč?
        Log  uživatel se musí odhlásit
        Logout
   ELSE
        Log  uživatel je již odhlášen
   END


Po_sade_uklid
   Close Browser

Seznam kurzu
   [Arguments]          ${URL}

   Go To                ${URL}
   Get Text             ${TEXT_Zajem}
   ${PocetKurzu} =      Get Element Count           ${SEL_CourseName}
   Log To Console       ${PocetKurzu}

   FOR     ${counter}     IN RANGE     0      ${PocetKurzu}
        Log  ${counter}
        ${NazevKurzu} =  Get Text      ${SEL_CourseName} >> nth=${counter}
        Log To Console     ${NazevKurzu}
   END



Login_s_kontrolou
   [Arguments]          ${Email}            ${Heslo}            ${JeUzivatelPrihlasen}

   Click              ${SEL_LoginLink} 
   Type Text          ${SEL_LoginEmailForm}            ${Email}
   Type Text          ${SEL_LoginPasswordForm}         ${Heslo}
   Click              ${SEL_LoginBtn} 
   Take Screenshot    

   # Podmínka pro kontrolu
     IF   "${JeUzivatelPrihlasen}" == "ano"
          Log To Console     Uživatel musí být přihlášen
          Get Text         ${SEL_UserLogoutBtn}       ==       ${TEXT_Odhlasit}
     ELSE
           Log To Console     Uživatel nesmí být přihlášen
           Get Text        ${SEL_LoginLink}          ==       ${TEXT_Prihlasit}  
     END



Registrace_do_kurzu
    [Arguments]     ${URL}
     Click                 ${SEL_RegistrationLink} >> nth=0
     Get Text              ${TEXT_Zajem}
     Take Screenshot
     Click                 ${SEL_RegistrationLink}
     Get Title       ==    ${TEXT_TitleRegistrace}
     Get Text              ${SEL_RegisterBtn}     ==      ${TEXT_Registrovat}

Chybova hlaska neplatne udaje
       Get Text   ${SEL_LoginWrongInput}   *=  ${ERROR_WrongCredentials}
       Take Screenshot    
       
Chybova hlaska prazdny email
       Get Text    ${SEL_LoginWrongInput}  *=  ${ERROR_EmptyEmail} 
       Take Screenshot

Chybova hlaska prazdne heslo
       Get Text    ${SEL_LoginErrorPassword}  *=  ${ERROR_EmptyPassword}
       Take Screenshot
       
Logout
   Click            ${SEL_UserLogoutBtn}
   Get Text         ${TEXT_Prihlasit}
