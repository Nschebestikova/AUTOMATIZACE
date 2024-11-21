*** Settings ***
Documentation     Přihlášení a odhlášení k API pomocí CSRF tokenu
Library           RequestsLibrary
Library           OperatingSystem

*** Variables ***
${BASE_URL}         http://testovani.kitner.cz
${LOGIN_ENDPOINT}   /login
${LOGOUT_ENDPOINT}  /logout
${USERNAME}         lector@lector.com
${PASSWORD}         lector@lector.com

*** Test Cases ***
Přihlásit a Odhlásit
    Přihlásit
    Odhlásit

*** Keywords ***
Přihlásit
    Create Session    APIKurzy    ${BASE_URL}

    # Příhlášení
    ${response}=    POST On Session    APIKurzy    ${LOGIN_ENDPOINT}    data={"username": "${USERNAME}", "password": "${PASSWORD}"}
#    ${response}=    POST On Session    APIKurzy    ${LOGIN_ENDPOINT}    data={"username": "chybnylogin", "password": "chybneheslo"}


Odhlásit
    POST On Session   APIKurzy    ${LOGOUT_ENDPOINT}
    Delete All Sessions
