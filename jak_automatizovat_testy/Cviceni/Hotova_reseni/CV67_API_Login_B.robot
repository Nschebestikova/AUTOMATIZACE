*** Settings ***
Documentation     Přihlášení a odhlášení k API pomocí CSRF tokenu
Library           RequestsLibrary
Library           OperatingSystem

*** Variables ***
${BASE_URL}         http://testovani.kitner.cz
${CSRF_ENDPOINT}    /sanctum/csrf-cookie
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
    Create Session    Kitner    ${BASE_URL}

    # Získání CSRF tokenu
#    ${response}=    GET On Session    Kitner    ${CSRF_ENDPOINT}

    # Příhlášení
    ${response}=    POST On Session    Kitner    ${LOGIN_ENDPOINT}    data={"username": "${USERNAME}", "password": "${PASSWORD}"}


Odhlásit
#    ${headers}=    Create Dictionary    X-CSRF-Token    ${CSRF_TOKEN}
    POST On Session   Kitner    ${LOGOUT_ENDPOINT}
    Delete All Sessions
