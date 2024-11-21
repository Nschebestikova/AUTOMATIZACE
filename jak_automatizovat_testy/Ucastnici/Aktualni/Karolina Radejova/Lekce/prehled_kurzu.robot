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
   #${jaky_by_stmode} =   Set Strict Mode      off #robot vybere jakykoli prvek ze seznamu prvku

   #${Kurz} =      Get Text           data-test=course_name
   #Log To Console       ${Kurz}
   #Set Strict Mode    ${jaky_by_stmode}
   
   ${Pocet_kurzu} =     Get Element Count    data-test=course_name
   Log To Console    ${Pocet_kurzu}
   
   FOR    ${counter}    IN RANGE    ${Pocet_kurzu}
       Log    Kolo: ${counter}
       ${Kurz} =      Get Text           data-test=course_name >> nth=${counter}
       Log To Console       ${Kurz}
        
   END    

Otevření stránky
   [Arguments]          ${pURL}

   New Page             ${pURL}
   Get Title  ==        Testování - Přehled kurzů