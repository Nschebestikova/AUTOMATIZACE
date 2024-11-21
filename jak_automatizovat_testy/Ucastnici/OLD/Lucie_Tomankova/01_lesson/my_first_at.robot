*** Settings ***
Library    OperatingSystem


*** Test Cases ***
#Cvičení č.3: vytvořit 2 pozitivní automatické testy na příkazovou řádku
AT_01 positive - Which version of Python do I have installed?
     ${Python} =   Run  Python --version
     Log To Console    ${Python}
     Should Contain    ${Python}  Python 3.11.3


AT_02 positive - Is there a file called this way?
     ${display} =  Run    dir
     Log To Console    ${display}     Aktualni
     Should Contain    ${display}  Aktualni


#AT_03 positive vynechám, to by stejně běžělo jenom na mým PC.


AT_04 positive - Can you count?
     ${result} =   Evaluate  5 + 5
     Log To Console     ${result}     10
     Should Be Equal As Integers     ${result}    10


#Cvičení č.4: vytvořit 2 negativní automatické testy na příkazovou řádku
AT_05 negative - Does Tasklist include info about Documents?
     ${memory} =  Run    tasklist
     Log To Console     Documents
     Should Contain    ${memory}  Documents


AT_06 negative - Network connections does not include Non-acitvebalabla?
     ${active} =  Run    netstat
     Log To Console     Non-acitvebalabla
     Should Not Contain    ${active}  Non-acitvebalabla


Experiment_01 - Greeting to Console
     ${string1} =    Run  echo Hello everybody
     Log To Console    ${string1}
     ${string2} =   Set Variable    Hello everybody
     ${resStr} =    Run Keyword And Return Status    Should Be Equal As Strings    ${string1}    ${string2}




























