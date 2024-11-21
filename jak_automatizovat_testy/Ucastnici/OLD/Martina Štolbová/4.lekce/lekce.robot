
*** Variables ***
{

${zvire} slon
*** Test Cases ***
IF    "${zvire}" == "slon"
         Log To Console    Je to slon
    ELSE
         Log To Console    není to slon

#https://docs.google.com/document/d/1Znhce4-LnOCMXd19BY1_q6xl3eKkXIn6wZmv0brnsB8/edit

FOR    ${counter}    IN RANGE    1    10    2
        Log To Console    ${counter}
    END


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

    ${Kurz} =      Get Text           data-test=course_name
   Log To Console       ${Kurz}
