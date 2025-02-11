*** Variables ***
@{Prehliadace}   Opera  Firefox  Chrome  Safari  Edge

*** Test Cases ***

# Vypiše všechny položky seznamu do logu
Zoznam prehliadacov
    Log Many    @{Prehliadace}

# Test pro vypsani jedne polozky ze seznamu
Jeden prehliadac
    Log To Console    ${Prehliadace}[2]

# Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Log To Console     ${Prehliadace}[0]
    Should Be Equal    ${Prehliadace}[0]    Chrome