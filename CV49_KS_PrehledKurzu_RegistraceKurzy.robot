*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
Jake kurzy jsou k dispozici na prehledu kurzu
    New Browser         headless=False
    Otevření stránky    ${URL}
    Seznam kurzu        ${URL}


*** Keywords ***
Otevření stránky
   [Arguments]          ${pURL}

   New Page             ${pURL}
   Get Title  ==        Testování - Přehled kurzů

Seznam kurzu
   [Arguments]          ${pURL}

   Go To                ${pURL}
   # Je třeba počkat až se všechny kurzy nahrají, to se zajistí čekáním na element na konci stránky
   Get Text             "Máte zájem o naše kurzy?"
   
   # spočítá kolik je tam kurzu podle počtu výskytu elementů s atributem data-test=course_name
   ${PocetKurzu} =      Get Element Count           data-test=course_name
   Log To Console       ${PocetKurzu}

#   Set Strict Mode      off

   # následující cyklus se provede tolikrát kolik je kurzů na stránce
   FOR    ${counter}    IN RANGE    0    ${PocetKurzu}    1
      Log To Console   Kolo: ${counter}
      ${JmenoKurzu} =      Get Text                    data-test=course_name >> nth=${counter}
      Log To Console       KURZ: ${JmenoKurzu}
   END


  # ukázk apoužití podmínky
  IF    ${PocetKurzu} > 3
    Log To Console    Kurzů je víc než 3!
  END



