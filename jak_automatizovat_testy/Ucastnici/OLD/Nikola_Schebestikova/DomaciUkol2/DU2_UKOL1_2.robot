** Settings ***
Library     OperatingSystem
Library     String


#globální variables pro testy
*** Variables ***
${PRIK1}             help cd     #vypíše veškeré info co je cd
${PRIK2}             help dir    #vypíš informace o dir
${PRIK3}             cd C:\Users\Nikola     #příkaz, co přepne do špatné složky
${PRIK4}             help Hello  #příkaz pro vypsání Hello - špatný test
${OUTPUT_TEXT}       Displays a list of files and subdirectories in a directory. #proměnná, kterou lze použít v asertaci a výsledku
${CMD}               Run

*** Test Cases ***
1 ukol funkce v cmd cd help pozitivní test
    ${cmd} =            Run             ${PRIK1}
    Should Contain      ${cmd}      Displays the name of or changes the current directory
    Log                 vysledek cmd prikazu 1 je tento ${prik1}        #OTÁZKA, LZE JEN VEPSAT PROMĚNNOU DO LOGU?
    Log                 vysledna hodnota testu cmd 1 je vypis ${cmd}    #DO LOGU JE POTŘEBA VEPSAT OBA VÝSLEDKY? NEBO JE TO JEN PRO NÁS?

2 ukol funkce help dir pozitivní test
    ${cmd} =            Run             ${PRIK2}
    Should Contain      ${cmd}    ${OUTPUT_TEXT}          #použití proměnné output text viz variables
    Log                 vysledek cmd prikazu 2 je tento ${PRIK2}
    Log                 vysledna hodnota testu cmd 2 je vypis/text cmd ${cmd}


3 ukol funkce cd přepnutí do složky negativní test
    ${cmd}              Run       ${PRIK3}
    Should Contain      ${cmd}    Systém nemůže nalézt uvedenou cestu
    Log     vysledek cmd prikazu testu 3 je ${PRIK3}
    Log     vysledna hodnota testu cmd 3 je ${cmd}

4 ukol špatně napsáno help negativní test
    ${cmd}              Set Variable   cd C:\Users\Nikola   #LOKÁLNÍ PROMĚNNÁ - ZKOUŠKA
    Log                 ${cmd}         Displays the name of or changes the current directory.
    Should Contain      ${cmd}  ${PRIK4}


*** Variables ***
${POZDRAV}     Ahoj
${JMENO}       Nikola

*** Test Cases ***
Výpis pozdravu do console
   Log to console   ${POZDRAV} ${JMENO}







