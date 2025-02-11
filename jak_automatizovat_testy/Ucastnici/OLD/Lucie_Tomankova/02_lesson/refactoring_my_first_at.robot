*** Settings ***
Library    OperatingSystem
Library    String
Library    BuiltIn
Documentation    V této složce se zabýváme refactoringem codu úkolu z první lekce, za účelem využití znalosti variables a keywords.Také refacturujeme zápis výpisu do logu. Plus testy, které nebyly negativní jsou opraveny na negativní. Plus se učíme kam dát documentation.


*** Variables ***
${answer01} =   Aktuální verze Pythnu na vašem počítači je
${answer02} =   Je to tak, vaši složku zde máme a jmenuje se
${answer03} =   Ano, dokážu počítat, váš výsledek je:
${answer04} =   Tasklist neobsahuje directory
${answer05} =   Vaše aktivní sítová spojení skutečně neobsahují
${answer06} =   Výsledek v konzoli je stejný jako očekávaný řetězec:


*** Test Cases ***
#Cvičení č.3: vytvořit 2 pozitivní automatické testy na příkazovou řádku
AT_01 positive
    [Documentation]    Which version of Python do I have installed?
    #To, o čem daný TC je, se píše sem? Je mi příjemnější to psát přímo do názvu TC. Co je standard?
    ${Python} =   Run  Python --version
    Should Contain    ${Python}  Python 3.11.3
    Answer    ${answer01}     ${Python}


AT_02 positive - Is there a file called this way?
     ${display} =  Run    dir
     Should Contain    ${display}  Aktualni
     Answer    ${answer02}     Aktualni


#AT_03 positive vynechám, to by stejně běžělo jenom na mým PC.


AT_04 positive - Can you count?
     ${result} =   Evaluate  5 + 5
     Should Be Equal As Integers     ${result}    10
     Answer     ${answer03}     10


Cvičení č.4: vytvořit 2 negativní automatické testy na příkazovou řádku
AT_05 negative - Does Tasklist include info about Documents?
    ${memory} =  Run    tasklist
    Answer    ${answer04}     Documents
    Should Contain    ${memory}  Documents


AT_06 negative - Network connections does not include Non-acitvebalabla?
    ${active} =  Run    netstat
    Should Not Contain    ${active}  Non-acitvebalabla
    Answer    ${answer05}     Non-acitvebalabla


Experiment_01 - Greeting to Console
    ${string1} =    Run  echo Hello everybody
    Log To Console    ${string1}
    ${string2} =   Set Variable    Hello everybody
    ${resStr} =    Run Keyword And Return Status    Should Be Equal As Strings    ${string1}    ${string2}
    Answer    ${answer06}       Hello everybody


*** Keywords ***
Answer
    [Arguments]     ${a}    ${b}
    ${oneString} =   Catenate  ${a}    ${b}
    Log    ${oneString}
    [Return]    ${oneString}

























