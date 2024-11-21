*** Settings ***
Library  OperatingSystem


*** Test Cases ***
Moj prvy test
  log  Ahoj         # hashtag je komentár
  Log To Console    nazdar

#Kontrola akcie
  Should Be Equal As Integers    ${2*2}  4

Pozitivny test
    ${res} =  run  help dir
    Should Contain    ${res}    Displays a list of files and subdirectories in a directory.

Negativny test
    ${res} =  run  help aaa
    Should Contain    ${res}    Displays a list of files and subdirectories in a directory.
