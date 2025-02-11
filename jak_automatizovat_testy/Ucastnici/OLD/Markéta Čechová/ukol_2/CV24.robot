
*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
@{PROHLIZECE}   Chrome  Mozilla  Edge  Opera  Safari


*** Test Cases ***

Test pro vypsani všech položek seznamu do logu
     Log    Všechny prohlížeče v seznamu jsou ${PROHLIZECE}


Test pro vypsani jedne polozky ze seznamu
    Log    Třetí položkou v seznamu je prohlížeč ${PROHLIZECE}[2]


Test pro oveření že 0 položka seznamu obsahuje Chrome
    Log To Console    První položkou v seznamu je ${PROHLIZECE}[0]
    ${polozka_0}=  Set Variable  Chrome
    Should Contain   ${PROHLIZECE}[0]   ${polozka_0}


