*** Settings ***
Library    Process

*** Test Cases ***
# Testovací případ pro ověření základní funkcionality
Ověření základní funkcionality prikazu echo
    # Ověříme, zda příkaz echo funguje správně a tedy se vypíše Hello World
    ${output}=          Run Process                 echo Hello World    shell=True
    Log                 ${output.stdout}
    Should Be Equal     ${output.stdout.strip()}    Hello World


