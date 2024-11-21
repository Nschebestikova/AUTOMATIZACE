# automatizace aplikace Windows Kalkulačka
# pip install rpaframework-windows
# Dokumentace: https://rpaframework.org/libraries/windows/index.html
# Nástroj pro vyhledání lokátorů https://accessibilityinsights.io/downloads/

*** Settings ***
Library    RPA.Windows

*** Tasks ***
Do some calculations
    [Setup]  Windows Run   calc.exe

#    Control Window    name:Calculator
    Control Window    name:Kalkulačka

#    Click    id:clearButton
    Click    name:Vymazat
    Send Keys   keys=96+4=
    ${result} =    Get Attribute    id:CalculatorResults    Name
    Log To Console    ${result}

    [Teardown]   Close Current Window

