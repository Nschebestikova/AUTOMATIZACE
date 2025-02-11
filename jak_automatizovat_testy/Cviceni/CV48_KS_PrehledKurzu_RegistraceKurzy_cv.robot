# CV přidat do CV41 a cv 41 mít jako hotové, jak to má vypadat
1. ukázat s chybou
2. ukázat jak vypnout strict mode
3. ukázat ja spočítat počet kurzu přes Get Element Count
3. ukázat jak přidat cyklus a vypsat všechny
4. CV nech si poradit kroky

** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
Jake kurzy jsou k dispozici na prehledu kurzu
   New Browser         headless=False
   Otevření stránky    ${URL}
   Seznam kurzu        ${URL}

*** Keywords ***
Seznam kurzu
   [Arguments]          ${pURL}

   Go To                ${pURL}

   # Je třeba počkat až se všechny kurzy nahrají, to se zajistí čekáním na element na konci stránky
   Get Text             "Máte zájem o naše kurzy?"

   ${NazevKurzu} =      Get Element Count           data-test=course_name
   Log To Console       ${NazevKurzu}


#   # spočítá kolik je tam kurzu podle počtu výskytu elementů s atributem data-test=course_name
#   # v dev tools je třeba najít  [data-test=course_name]
#   ${PocetKurzu} =      Get Element Count           data-test=course_name
#   Log To Console       ${PocetKurzu}



Otevření stránky
   [Arguments]          ${pURL}

   New Page             ${pURL}
   Get Title  ==        Testování - Přehled kurzů






