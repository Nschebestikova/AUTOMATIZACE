*** Settings ***
Library  Browser
Documentation  Načtení kurzů a přihlášení na kurz.

*** Variables ***
${pageURL}      http://testovani.kitner.cz/courses
${pageURL2}     http://testovani.kitner.cz/courses/1

*** Test Cases ***
Načtení kurzů, jaké jsou k dispozici
  New Browser                     headless=false
  Otevření stránky s kurzy        ${pageURL}
  Seznam kurzu a načtení seznamu  ${pageURL}


Výběr a přihlášení na kurz
  New Browser         headless=False
  Otevření stránky s kurzy        ${pageURL}
  Registrace na kurz              ${pageURL2}



*** Keywords ***
#ARGUMENTY A KS PRO NAČTENÍ SEZNAMU KURZŮ
Seznam kurzu a načtení seznamu
   [Arguments]          ${pageURL}

   Go To                ${pageURL}
   Wait Until Page Contains Element   css=[data-test=course_name]
   ${Pocet} =   Get Element Count   css=[data-test=course_name]
   ${kurzy} =   Get Texts   css=[data-test=course_name]
   Log Many   ${kurzy}

# ARGUMENTY PRO OTVĚVŘENÍ STRÁNKY NA KTEROU PŘEJDEME A VYBEREME KURZ
Otevření stránky s kurzy
   [Arguments]          ${pageURL}

   New Page             ${pageURL}
   Wait Until Page Contains Element   css=[data-test=course_name]

#vytvoření registrace - kliknutí na registraci prvního kurzu
Registrace na kurz
   [Arguments]    ${pageURL2}

   Go To         ${pageURL2}
   Wait Until Page Contains Element   css=[data-test=registration_link]
   Click Link    data-test=registration_link
   Wait Until Page Contains Element   css=[data-test=registration_form]
   # Místo Get Text použijte pro odkaz na registraci Wait Until Page Contains Element nebo klikněte přímo na odkaz.