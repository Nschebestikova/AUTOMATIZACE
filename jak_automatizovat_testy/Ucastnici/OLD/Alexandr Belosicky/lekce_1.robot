*** Settings ***
Library  OperatingSystem   #timto pripojuji knihovnu, abych nize mohl pouzit prikaz run ve tretim testu

*** Test Cases ***
Muj prvni test
    log  Ahoj
    Log To Console    zdar

Muj druhy test
    log  Ahoj   # komentář
    Should Be Equal As Integers    ${2 + 2}   4

Muj pozitivni treti test
    ${res} =    Run    help dir

    Should Contain    ${res}    Displays a list    #toto je kontrola, když zadám příkaz help dir, tak kontroluje, zda tam vyjede tento text

Muj negativni treti test
    ${res} =    Run    help aaa

    Should Contain    ${res}    This command is not supported by the help utility.    #toto je kontrola negativní, když zadám příkaz help aaa (chybný příkaz), tak kontroluje, zda tam vyjede tento text


