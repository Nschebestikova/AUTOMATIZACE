** Settings ***
Library     OperatingSystem
Library     String


*** Test Cases ***
1 ukol funkce v cmd cd help pozitivní test
    ${cmd} =       Run             help cd
    Log                 ${cmd}
    Should Contain      ${cmd}     Displays the name of or changes the current directory.

2 ukol funkce help dir pozitivní test
    ${cmd} =       Run             help dir
    Log                 ${cmd}
    Should Contain      ${cmd}     Displays a list of files and subdirectories in a directory.

3 ukol funkce cd přepnutí do složky negativní test
    ${cmd}         Run             cd C:\Users\Nikola
    Log                 ${cmd}
    Should Contain      ${cmd}     Systém nemůže nalézt uvedenou cestu

4 ukol špatně napsáno help negativní test
    ${cmd}         Run            help Hello
    Log                 ${cmd}
    Should Contain      ${cmd}    Displays the name of or changes the current directory.

# Zakomentování - zkouška
Další testík
    ${print}       Run         Hello
   Log              ${print}
   Should Contain   ${print}   Hello
# ZAKOMENTOVÁNÍ VŠEHO CTRL + lomítko na Numerické klávesnici






