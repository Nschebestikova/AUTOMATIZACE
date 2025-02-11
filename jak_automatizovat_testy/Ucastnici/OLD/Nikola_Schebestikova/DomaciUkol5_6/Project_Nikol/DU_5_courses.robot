*** Settings ***
Library     Browser
Resource    C:/Users/Nikča/PycharmProjects/Jak_automatizovat_testy/jak_automatizovat_testy/Ucastnici/Aktualni/Nikola_Schebestikova/Projekt/Data_and_Config/KonfiguraceN.robot
Resource    C:/Users/Nikča/PycharmProjects/Jak_automatizovat_testy/jak_automatizovat_testy/Ucastnici/Aktualni/Nikola_Schebestikova/Projekt/Data_and_Config/TestovaciData.robot
# U TÉ CESTY, MI TA RELATIVNÍ NEŠLA, NETUŠÍM, ZDÁ NEDĚLÁ PROBLÉM TEN RF A TAK, JDE MI JEN TADY TA ABSOLUTNÍ?

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}   #TIMEOUT PRO VŠECHNY TESTY # TIMEOUTY PRO VŠECHNY TESTY

*** Variables ***
${pageURL2}     http://testovani.kitner.cz/courses/1


*** Test Cases ***
Načtení kurzů, jaké jsou k dispozici
  New Browser     chromium        headless=false
  Otevření stránky s kurzy        ${pageURL}
  Pocet kurzu                     ${pageURL}
  Take Screenshot

Načtení názvů kurzů
  New Browser     chromium        headless=false
  Otevření stránky s kurzy        ${pageURL}
  Názvy kurzů                     ${pageURL}
  Take Screenshot

#kurz na přihlášení - konkrétně tlačítko registrovat se, bez kompletní registrace (registraci jsem raději nedělala...)
Výběr a přihlášení na kurz
  New Browser     chromium        headless=false
  Otevření stránky s kurzy        ${pageURL}
  Registrace na kurz              ${pageURL2}
  Take Screenshot


*** Keywords ***
#ARGUMENTY A KS PRO NAČTENÍ SEZNAMU KURZŮ
Pocet kurzu
    [Arguments]          ${pageURL}
     Go To               ${pageURL}
    Take Screenshot
    ${Pocetkurzu} =   Get Element Count   css=[data-test=course_name]
     Wait For Elements State    "Máte zájem o naše kurzy?"   timeout=11 s
     Log To Console   ${Pocetkurzu}

  #cyklus pro kurzy pro zobrazení počtu kurzů - elementu ze stránky
    FOR   ${counter}   IN RANGE  ${PocetKurzu}
          Log To Console    ${counter}
    END


Názvy kurzů
    [Arguments]          ${nazvykurzu}
    Go To                ${pageURL}
    Wait For Elements State      text="Zaregistrujte se zde"   timeout=15s
    ${Pocetkurzu} =   Get Element Count   css=[data-test=course_name]


#CYKLUS PRO VÝPIS KURZŮ
    FOR    ${counter}    IN RANGE     ${Pocetkurzu}
        Log To Console    ${counter}
        ${nazvykurzu}=       Get Text  css=[data-test=course_name] >> nth=${counter}
        Log To Console    ${nazvykurzu}
    END



# ARGUMENTY PRO OTVĚVŘENÍ STRÁNKY NA KTEROU PŘEJDEME A VYBEREME KURZ
Otevření stránky s kurzy
   [Arguments]          ${pageURL}

   New Page             ${pageURL}
   Get Title  ==        Testování - Přehled kurzů  #ověření titulku stránka

#vytvoření registrace - kliknutí ne registraci prvního kurzu
Registrace na kurz
   [Arguments]    ${pageURL2}

   Go To         ${pageURL2}
   ${b_timeput} =    Set Browser Timeout    2m 30 seconds   #je třeba použít počkání ne element, protože to nestíhá najít a pádá to (nápověda v Browser R.F.)
   Click             data-test=registration_link
   Set Browser Timeout    ${b_timeput}
   Get Url   ==    http://testovani.kitner.cz/register
   Take Screenshot
   Type Text       data-test=name_input       ${name}
   Type Text       data-test=email_input      ${email}
   Type Text       data-test=password_input   ${password}
   Type Text       data-test=password_again_input    ${password}
   Click           data-test=register_button



