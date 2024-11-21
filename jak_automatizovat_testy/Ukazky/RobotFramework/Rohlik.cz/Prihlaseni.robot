
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser

Resource        TestData.robot
Resource        Configuration.robot


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Prihlaseni bad login
    Login               neexistujici@uzivatel.cz          spravneheslo         Účet
Prihlaseni bad heslo
    Login               xoyoxaw283@evvgo.com              chyba                Účet
Prihlaseni success
    Login               xoyoxaw283@evvgo.com              spravneheslo         JT
    Logout


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
   [Arguments]      ${Email}            ${Heslo}            ${Text}

   Otevri rohlik a nastav geolokaci

   Cookie           AcceptAll

   Click            data-test=header-user-icon
   Type Text        id=email       ${Email}     delay=50ms
   Type Text        id=password    ${Heslo}     delay=50ms
   Click            data-test=btnSignIn

#  KONTROLA: Potřebuji vědět zdauživatel je nebo není přihlášen
   IF    "${Text}" == "Účet"
       Get Text     data-test=header-user-icon         contains            Účet
   ELSE
       Get Text     data-test=header-user-icon         contains            ${Text}
   END


Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

Otevri rohlik a nastav geolokaci
    New Browser        headless=false
    ${permissions} =   Create List    geolocation   # vytvoří seznam co je povoleno (v tomto případě zjištění polohy)
    New Context        permissions=${permissions}   # záznam, rozlišení, povolení zjištování polohy
    Set Geolocation    50.0859772  14.4083842  3    # zadá prohlížeči polohu: Praha - Kampa

    New Page         ${URL}
    Get Title        contains            Online supermarket Rohlik.cz


Logout
    Go to               ${URL}
    Click               ${SEL_HeaderLogin}
    Click               ${SEL_UserBoxLogoutBtn}
    # ověřit, že došlo k odhlášení
    Get Text            ${SEL_HeaderLogin}              contains                                ${TEXT_Prihlasit}
