*** Settings ***
Library  OperatingSystem

*** Variables ***
${pozdrav}  ahoj
${meno} =  Janka
${y} =     20
${x} =     10


# ${v} =  Evaluate  ${x} * ${y}

*** Test Cases ***
Test evaluation
  Log To Console    ${x}
  Log To Console    ${y}
  ${v} =  Evaluate  ${x} * ${y}
  Log To Console    vysledek: ${v}
  Should Be Equal as numbers  ${v}  200

Praca so zoznamom
  @{list} =  Create List  prvni  druhy  treti
  #Log To Console    @{list}
  #Log To Console    ${list}[0]
  #Log Many  @{list}

Praca so slovnikom
  &{list} =  Create Dictionary  jablko=10  banan=20  chleba=80
    Log To Console  ${list1}[banan]
    Log Many        &{list1} 


Test variables
  Log To Console    ${y}
  Should Be Equal  ${y}  20
 # ${x} =  Set Variable  10
 # ${pozdrav} =  Set Variable  Zina
 # Log To Console    ${pozdrav}
 # Log To Console    ${x}

Test prikazu ver - pozitivny
  ${WindowsVersion} =  Run  ver
  Log To Console    ${WindowsVersion}
  Should Contain    ${WindowsVersion}  Microsoft Windows [Version 10.0.19045.2728]

Test prikazu ver - negativny 1
  ${WindowsVersion} =  Run  ver1
  Log To Console    ${WindowsVersion}
  Should Contain    ${WindowsVersion}  'ver1' is not recognized as an internal or external command

Test prikazu ver - negativny 2
  ${WindowsVersion} =  Run  verr
  Log To Console    ${WindowsVersion}
  Should Contain    ${WindowsVersion}  'verr' is not recognized as an internal or external command

Test prikazu cd - pozitivny 1
#v tomto pripade som si nie ista, ci to mozem spravit takto, ale zda sa, ze ano, kedze vysledok sedi :)
  Run  ${EXECDIR}
  Log To Console    ${EXECDIR}
  Should contain    ${EXECDIR}  C:\\Users\\MartinaDurdikovaTese\\PycharmProjects\\jak_automatizovat_testy
#kde najdem zoznam bultin premennych?

Test prikazu cd - pozitivny 2
  ${vypisAktZlozku} =   Run  cd
  Log To Console    ${vypisAktZlozku}
  Should contain    ${vypisAktZlozku}  C:\\Users\\MartinaDurdikovaTese\\PycharmProjects\\jak_automatizovat_testy

Test prikazu cd - negativny 1
  ${vypisKdeSom} =   Run  cd a
  Log To Console    ${vypisKdeSom}
  Should contain    ${vypisKdeSom}  Syst‚m nem…§e nal‚zt uvedenou cestu.
#Systém nemůže nalézt uvedenou cestu. - toto je hlaska, ktora sa realne vypise v cmd.
#Je mozne dako upravit nastavenie, aby sme kontrolovali original hlasku?