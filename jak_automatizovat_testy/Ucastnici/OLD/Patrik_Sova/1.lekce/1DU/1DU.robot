*** Settings ***
Metadata    Author    Patrik Sova
Metadata    Purpose   Automation of Windows Calculator
Metadata    Created   26.11.2023
Documentation       Simple Functional Test
...
...             Přes okno Spustit se spustí kalkulačka
...             Proběhnou 2 positivní testy + a -
...             A pak 2 negativní testy na dělení 0 a log(0)
...             Program se pak automaticky zavře
Library     RPA.Windows

*** Tasks ***

Start app

    Windows Run   calc.exe
    Control Window    name:Kalkulačka

Positive_"+"_calculations_1     #7+9=16, klikání myší

    Click    id:num7Button
    Sleep    0.5s
    Click    id:plusButton
    Sleep    0.5s
    Click    id:num9Button
    Click    id:equalButton
    Sleep    0.5s
    ${result} =    Get Attribute    id:CalculatorResults    Name
    Should Contain    ${result}    16
    Log To Console    ${result}

Positive_"-"_calculations_2     #8-2=6, zadání přes klávesnici
    Click    name:"Vymazat položku"
    Sleep      1
    Send Keys   keys={5}
    Sleep       0.5s
    Send Keys   keys={-}
    Sleep       0.5s
    Send Keys   keys={3}
    Sleep       0.5s
    Send Keys   keys={Enter}

    ${result} =    Get Attribute    id:CalculatorResults    Name
    Should Contain    ${result}    2
    Log To Console    ${result}

Negative_"/0"_calculations_1    #dělení nulou
    Click    name:"Vymazat položku"
    Click    id:num7Button
    Sleep    0.5s
    Click    id:divideButton
    Sleep    0.5s
    Click    id:num0Button
    Sleep    0.5s
    Click    id:equalButton
    Sleep    0.5s
    ${result_negative} =    Get Attribute    id:CalculatorResults    Name
    Should Contain    ${result_negative}    nedá
    Log To Console    ${result_negative}

Negative_"log0"_calculations_2  #log(0)
    Click    name:"Vymazat"
    Click    id:num0Button
    Sleep    0.5s
    Click    id:logBase10Button
    ${result_negative} =    Get Attribute    id:CalculatorResults    Name
    Should Contain    ${result_negative}    Neplatné
    Log To Console    ${result_negative}

End app

    Close Current Window
    Log To Console    Vše proběhlo, už se nic testovat nebude :)