
# CV přidat do CV41 a cv 41 mít jako hotové, jak to má vypadat
1. ukázat s chybou
2. ukázat jak vypnout strict mode
3. ukázat ja spočítat počet kurzu přes Get Element Count
3. ukázat jak přidat cyklus a vypsat všechny


** Settings ***
Library  Browser

Resource    ../Projekt/TestData.robot

Test Setup          Pred_testem
Test Teardown       Uklid_po_testu

Suite Setup         Pred_sadou
Suite Teardown      Uklid_sada


*** Test Cases ***
Jake kurzy jsou k dispozici na prehledu kurzu
   New Browser         headless=False
   Otevreni stranky    ${URL}
   Seznam kurzu        ${URL}

Prihlaseni

#    Otevreni stranky             ${URL}
#   KS                           login               heslo           ocekavam uspesne prihlaseni
    Prihlaseni s kontrolou       ${loginCorrect}       ${loginCorrPw}        ano

Prihlaseni spatne heslo - neg

#    Otevreni stranky             ${URL}
#   KS                           login               heslo           ocekavam uspesne prihlaseni
    Prihlaseni s kontrolou       ${loginCorrect}       ${loginIncorrPw}       ne

Odhlaseni

#    Otevreni stranky             ${URL}

#   KS                           login                     heslo             ocekavam uspesne prihlaseni
    Prihlaseni s kontrolou       ${loginCorrect}       ${loginCorrPw}        ano

#   KS                           ocekavam uspesne odhlaseni
    Odhlaseni s kontrolou        ano

Odhlaseni pres jiny link - neg

#    Otevreni stranky             ${URL}

#   KS                           login                     heslo             ocekavam uspesne prihlaseni
    Prihlaseni s kontrolou       ${loginCorrect}       ${loginCorrPw}        ano

#   KS                                              ocekavam stranku profil
    Odhlaseni pres jiny link s kontrolou - neg      ano


Registrace
#    Otevreni stranky             ${URL}

#   KS                           name                   login               heslo               ocekavam uspesne prihlaseni
    Registrace s kontrolou       ${loginCorrName}       ${loginCorrect}     ${loginCorrPw}      ano

Registrace se zabranym mailem - neg
    Otevreni stranky             ${URL}

#   KS                                                 name                 login               heslo              ocekavam uspesne prihlaseni
    Registrace s kontrolou na zabrany mail - neg       ${loginCorrName}     ${loginCorrect}     ${loginCorrPw}     ano


*** Keywords ***

Pred_sadou
    New Browser         headless=False
    New Page            ${URL}
    Get Title   ==      ${courseSummary}
    Sleep               ${SleepBeforeTest}

Uklid_sada
    Close Browser

Pred_testem
    New Page               ${URL}
    Sleep                  ${SleepBeforeTest}

Uklid_po_testu
    Go To               ${URL}


Seznam kurzu
   [Arguments]          ${pURL}

   Go To                ${pURL}

#   Sleep                  1              # kvůli dynamičnosti je třeba zde dávat tento příkaz, aby se to stihlo načíst, jinak nenačte - lazy loading toto je možnost selenia natvrdo

   # Je třeba počkat až se všechny kurzy nahrají, to se zajistí čekáním na element na konci stránky
   Get Text             "${courseInterest}"   #toto je dynamické čekání - moderní pro playwright - framework r. = ČEKÁNÍ NA OBJEKT/NĚJAKÝ TEXT A NAHRAZUJE TO SLEEP = BUDE TO STOKRÁT RYCHLEJŠÍ/RADŠI NEVYUŽÍVAT SLEEPY!!!

   Take Screenshot
   ${old_mode} =      Set Strict Mode    False

   ${PocetKurzu} =   Get Element Count   ${SEL_course_name}

   ${nazev_kurzu}    Get Text    ${SEL_course_name}  >>  nth=0
   Log To Console    ${nazev_kurzu}

   FOR   ${counter}   IN RANGE  ${PocetKurzu}
          Log    ${counter}
          ${nazev_kurzu} =  Get Text    ${SEL_course_name}  >>  nth=${counter}
          Log To Console    ${nazev_kurzu}
   END

#   # spočítá kolik je tam kurzu podle počtu výskytu elementů s atributem data-test=course_name
#   # v dev tools je třeba najít  [data-test=course_name]
#   ${PocetKurzu} =      Get Element Count           data-test=course_name
#   Log To Console       ${PocetKurzu}


Otevreni stranky
    [Arguments]          ${pURL}

    New Page             ${pURL}
    Get Title  ==        ${courseSummary}

Prihlaseni s kontrolou
    [Arguments]         ${Email}            ${Heslo}            ${Prihlasen}

    #prihlaseni
    Click            ${SEL_login_link}
    Type Text        ${SEL_email_input}               ${Email}
    Type Text        ${SEL_password_input}            ${Heslo}
    Click            ${SEL_login_button}

    #kontrola
    IF    "${Prihlasen}" == "ano"
        Log To Console  ${userLoggedin}
        Get Text       ${SEL_logout_button}           ==       ${logoutText}
    ELSE
        Log To Console    ${userLoggedout}
    END

Odhlaseni s kontrolou
    [Arguments]         ${Odhlasen}

    #odhlaseni
    Get Text         ${SEL_logout_button}          ==       ${logoutText}
    Click            ${SEL_logout_button}


    #kontrola
    IF    "${Odhlasen}" == "ano"
        Log To Console      ${userLoggedout}
        Get Text            ${SEL_login_link}       ==       ${loginText}
    ELSE
        Log To Console      ${userLoggedin}
    END

Prihlasen
    [Arguments]     ${Text}
    Get Text        ${SEL_logout_button}          ==       ${logoutText}

Neni prihlasen
    Get Text        ${SEL_login_link}          ==       ${loginText}


Registrace s kontrolou
    [Arguments]         ${Name}            ${Email}            ${Heslo}            ${Zaregistrovan}

    #hlavni strana
    Get Text             "${courseInterest}"

    #registrace
    Click            ${SEL_login_link}
    Click            ${SEL_register_link}
    Type Text        ${SEL_name_input}                 ${Name}
    Type Text        ${SEL_email_input}                ${Email}
    Type Text        ${SEL_password_input}             ${Heslo}
    Type Text        ${SEL_password_again_input}       ${Heslo}
    Click            ${SEL_register_button}

    #kontrola uspesne registrace
    IF    "${Zaregistrovan}" == "ano"
        Log To Console      ${regSucc}
        Get Text            ${SEL_home_section}       ==       ${welcomeUser} ${name}!
    ELSE
        Log To Console      ${regUnsucc}
    END


Registrace s kontrolou na zabrany mail - neg
    [Arguments]         ${Name}            ${Email}            ${Heslo}            ${Zabrany_mail}

    #hlavni strana
    Get Text             "${courseInterest}"


    #registrace
    Click            ${SEL_login_link}
    Click            ${SEL_register_link}
    Type Text        ${SEL_name_input}                 ${Name}
    Type Text        ${SEL_email_input}                ${Email}
    Type Text        ${SEL_password_input}             ${Heslo}
    Type Text        ${SEL_password_again_input}       ${Heslo}
    Click            ${SEL_register_button}

    #kontrola zabraneho mailu registrace
    IF    "${Zabrany_mail}" == "ano"
        Log To Console      ${NegTestSucc}
        Get Text            ${SEL_email_input_errors}         ==       ${regMailInUse}
    ELSE
        Log To Console      ${NegTestFail}
    END


Prihlaseni spatne heslo s kontrolou - neg
    [Arguments]         ${Email}            ${Heslo}            ${Prihlasen}

    #prihlaseni
    Click            ${SEL_login_link}
    Type Text        ${SEL_email_input}               ${Email}
    Type Text        ${SEL_password_input}            ${Heslo}
    Click            ${SEL_login_button}

    #kontrola
    IF    "${Prihlasen}" == "ne"
        Log To Console      ${negTestSucc}
        Get Text            ${SEL_email_input_errors}       ==       ${wrongCredLogin}
    ELSE
        Log To Console      ${negTestFail}
    END

Odhlaseni pres jiny link s kontrolou - neg
    [Arguments]         ${Tlacitko_odhlaseni}

    #odhlaseni
    Get Text         ${SEL_courses_profile}          ==       ${myProfile}
    Click            ${SEL_courses_profile}


    #kontrola
    IF    "${Tlacitko_odhlaseni}" == "ano"
        Log To Console      ${negTestSucc}
        Get Text            ${SEL_logout_button}          ==       ${logoutText}
    ELSE
        Log To Console      ${negTestFail}
    END