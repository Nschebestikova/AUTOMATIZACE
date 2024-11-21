*** Settings ***
Metadata    Author    Patrik Sova
Metadata    Purpose   Automation of Windows Calculator
Metadata    Created   4.12.2023
Documentation       Simple Functional Test
...
...             Přes okno Spustit se spustí kalkulačka
...             Proběhnou 2 positivní testy + a -
...             A pak 2 negativní testy na dělení 0 a log(0)
...             Program se pak automaticky zavře
Library     RPA.Windows


*** Variables ***
${pause}            0.5s
${idres}            id:CalculatorResults
${rm}               name:"Vymazat položku"
${final_word}       Vše proběhlo, už se nic testovat nebude
${app}              calc.exe
${name_app}         name:Kalkulačka

*** Keywords ***
GetPositive_1
    ${result} =    Get Attribute    ${idres}    Name
    Should Contain    ${result}    16
    Log To Console    ${result}
    Log               ${result}
GetPositive_2
    ${result} =    Get Attribute    ${idres}    Name
    Should Contain    ${result}    2
    Log To Console    ${result}
    Log               ${result}
GetNegative_1
    ${result_negative} =    Get Attribute    ${idres}    Name
    Should Contain    ${result_negative}    nedá
    Log To Console    ${result_negative}
    Log               ${result_negative}
GetNegative_2
    ${result_negative} =    Get Attribute    ${idres}   Name
    Should Contain    ${result_negative}    Neplatné
    Log To Console    ${result_negative}
    Log               ${result_negative}
*** Tasks ***

Start app

    Windows Run         ${app}
    Log                 ${app}
    Control Window      ${name_app}
    Log                 ${name_app}

Positive_"+"_calculations_1     #7+9=16, klikání myší

    Click    id:num7Button
    Sleep    ${pause}
    Log      ${pause}
    Click    id:plusButton
    Sleep    ${pause}
    Log      ${pause}
    Click    id:num9Button
    Click    id:equalButton
    Sleep    ${pause}
    Log      ${pause}

    GetPositive_1

Positive_"-"_calculations_2     #8-2=6, zadání přes klávesnici
    Click    ${rm}
    Log      ${rm}
    Sleep      1
    Send Keys   keys={5}
    Sleep       ${pause}
    Log         ${pause}
    Send Keys   keys={-}
    Sleep       ${pause}
    Log         ${pause}
    Send Keys   keys={3}
    Sleep       ${pause}
    Log         ${pause}
    Send Keys   keys={Enter}

    GetPositive_2

Negative_"/0"_calculations_1    #dělení nulou
    Click    ${rm}
    Log      ${rm}
    Click    id:num7Button
    Sleep    ${pause}
    Log      ${pause}
    Click    id:divideButton
    Sleep    ${pause}
    Log      ${pause}
    Click    id:num0Button
    Sleep    ${pause}
    Log      ${pause}
    Click    id:equalButton
    Sleep    ${pause}
    Log      ${pause}

    GetNegative_1

Negative_"log0"_calculations_2  #log(0)
    Click    name:"Vymazat"
    Click    id:num0Button
    Sleep    ${pause}
    Log      ${pause}
    Click    id:logBase10Button

    GetNegative_2

End app

    Close Current Window
    Log To Console    ${final_word}
    Log               ${final_word}