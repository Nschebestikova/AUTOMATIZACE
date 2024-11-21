** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Test Cases ***
Jake kurzy jsou k dispozici na prehledu kurzu
   New Browser         headless=false
   Otevření stránky    ${URL}
   Seznam kurzu        ${URL}

*** Keywords ***
Seznam kurzu
   [Arguments]          ${pURL}

   Go To                ${pURL}

   # Je třeba počkat až se všechny kurzy nahrají, to se zajistí čekáním na element na konci stránky
   Get Text             "Máte zájem o naše kurzy?"
# tato podmínka vyřešila vybrání jednoho kurzu
#   ${jaky_stmode} =     Set Strict Mode    off


# tato podmínka vyřešila vybrání jednoho kurzu
#   Set Strict Mode      ${jaky_stmode}

   ${pocet_kurzu} =     Get Element Count    data-test=course_name
   Log To Console       ${pocet_kurzu}

   FOR    ${counter}    IN RANGE    ${pocet_kurzu}
       Log To Console       Kolo: ${counter}
       ${Kurz} =            Get Text           data-test=course_name >> nth=${counter}
       Log To Console       ${Kurz}
   END

Otevření stránky
   [Arguments]          ${pURL}

   New Page             ${pURL}
   Get Title  ==        Testování - Přehled kurzů