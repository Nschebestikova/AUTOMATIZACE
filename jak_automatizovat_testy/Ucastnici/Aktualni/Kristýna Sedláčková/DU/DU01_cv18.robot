#Opravte 5 chyb v odsazení u následujících automatikých testů

*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
#tady byla mezera navíc
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  DIR  #chybělo odsazení od kraje


Druhy test negativni
    ${res} =        run     help ahoj  #rovná se přiřazeno do prvního sloupce
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.