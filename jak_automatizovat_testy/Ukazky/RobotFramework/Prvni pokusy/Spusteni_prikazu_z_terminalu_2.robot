*** Settings ***
Library    OperatingSystem

*** Test Cases ***
# Testovací případ pro ověření základní funkcionality
Ověření základní funkcionality prikazu echo
    # Ověříme, zda příkaz echo funguje správně a tedy se vypíše Hello World
    ${output}=          Run                 echo Hello World
    Log                 ${output}
    Should Be Equal     ${output.strip()}   Hello World
                #poznámka ${output.strip()} odstraní bílé znaky na začátku a konci řetězce


