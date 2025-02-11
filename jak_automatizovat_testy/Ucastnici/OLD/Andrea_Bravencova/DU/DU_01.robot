*** Settings ***
Library  OperatingSystem

*** Test Cases ***
Exercise 1 - Positive Test
    ${res} =  run  ls Cviceni

    Should Contain    ${res}    CV11_PrvniAT.robot

Exercise 2 - Positive Test
    ${res} =  run  ls Ukazky

   Should Start With    ${res}     Cypress

Exercise 3 - Negative Test
    ${res} =  Run  ls NonExistentFile.robot

    Should Contain    ${res}     No such file or directory

Exercise 4 - Negative Test
    ${res} =  Run  ls Cviceni

    Should End With    ${res}     report.html





