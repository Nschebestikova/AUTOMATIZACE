*** Settings ***
Library  OperatingSystem

*** Variables ***
${WinVersion} =  Microsoft Windows [Version 10.0.19045.2728]
${negativnaHlaska1}  'ver1' is not recognized as an internal or external command
${negativnaHlaska2}  'verr' is not recognized as an internal or external command
${KdeSom}  C:\\Users\\MartinaDurdikovaTese\\PycharmProjects\\jak_automatizovat_testy
${neexistujucaZlozka}  Syst‚m nem…§e nal‚zt uvedenou cestu.

*** Test Cases ***
Test prikazu ver - pozitivny
  ${WindowsVersion} =  Run  ver
  Log To Console    ${WindowsVersion}
  Should Contain    ${WindowsVersion}  ${WinVersion}
  Log  Vysledok testu ver - pozitivny: ${WinVersion}

Test prikazu ver - negativny 1
  ${WindowsVersion} =  Run  ver1
  Log To Console    ${WindowsVersion}
  Should Contain    ${WindowsVersion}  ${negativnaHlaska1}
  Log  Vysledok testu prikazu ver - negativny 1: ${negativnaHlaska1}

Test prikazu ver - negativny 2
  ${WindowsVersion} =  Run  verr
  Log To Console    ${WindowsVersion}
  Should Contain    ${WindowsVersion}  ${negativnaHlaska2}
  Log  Vysledok testu prikazu ver - negativny 2: ${negativnaHlaska2}

Test prikazu cd - pozitivny 1
  Run  ${EXECDIR}
  Log To Console    ${EXECDIR}
  Should contain    ${EXECDIR}  ${KdeSom}
  Log  Vysledok testu prikazu cd - pozitivny 1: ${KdeSom}


Test prikazu cd - pozitivny 2
  Actual directory  #snaha o pouzitie vlastnych keywords
  Log  Vysledok testu prikazu cd - pozitivny 2: ${KdeSom}

Test prikazu cd - negativny 1
  ${vypisKdeSom} =   Run  cd a
  Log To Console    ${vypisKdeSom}
  Should contain    ${vypisKdeSom}  ${neexistujucaZlozka}
  Log  Vysledok testu prikazu cd - negativny 1: ${neexistujucaZlozka}


*** Keywords ***
Actual directory
  ${vypisAktZlozku} =   Run  cd
  Log To Console    ${vypisAktZlozku}
  Should contain    ${vypisAktZlozku}  ${KdeSom}
