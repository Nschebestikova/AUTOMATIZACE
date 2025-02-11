*** Settings ***
Library  Browser

*** Variables ***
${MENU_NOT_LOGGEDIN}  Ovládací panel  Přihlášení  Registrace  Zapomenuté Heslo  Přidat film  Přidat tvůrce
${MENU_LOGGEDIN}      Ovládací panel  Automatestik  Pošta  Oblíbení uživatelé  Chci vidět  Filmotéka  Poznámky  Spřízněné duše  Návštěvníci  Nastavení  Přítomní  Odhlásit
${MOVIE}              Můj soused Totoro
*** Test Cases ***
Starting a browser with succesful log in and log out
    PositiveLogin           Automatestik    4testik       LoggedIn
    Logout
Starting a browser with unsuccesful log in
    NegativeLogin           NonExistent     NonExistent    NotLoggedIn
Add movie a star
    PositiveLogin           Automatestik    4testik       LoggedIn
    Search for movie
    Change a Star
    Logout

*** Keywords ***

Browser Start
    New Browser    chromium    headless=false
    New Page        https://www.csfd.cz/
    Click           id=didomi-notice-agree-button
    Get Title      ==    ČSFD.cz

GoToLogin
    Click           "Můj účet"
    Get Variables   ${MENU_NOT_LOGGEDIN}
    Go To           https://www.csfd.cz/prihlaseni/
    Get Text        "Účet uživatele ČSFD"

PositiveLogin
    Browser Start
    GoToLogin
    [Arguments]     ${username}  ${password}  ${text}
    Type Text       id=frm-loginForm-username  ${username}
    Type Text       id=frm-loginForm-password  ${password}
    Click           css=[type="submit"][name="send"]
    IF    "${text}" == "LoggedIn"
       Get Text         "Nové trailery a rozhovory"
       Log To Console    User ${username} succesfully logged in.
    ELSE
       Log To Console    Something went wrong.
    END

NegativeLogin
    Browser Start
    GoToLogin
    [Arguments]     ${username}  ${password}  ${text}
    Type Text       id=frm-loginForm-username  ${username}
    Type Text       id=frm-loginForm-password  ${password}
    Click           css=[type="submit"][name="send"]
    IF    "${text}" == "NotLoggedIn"
        Get Element       id=snippet--flashes
        Log To Console    User ${username} is not logged in.
    ELSE
        Log To Console    Something went wrong.
    END

Search for movie
    Type Text    css=.tt-input  ${MOVIE}
    Click        css=.btn-search
    Click        "${MOVIE}"
    Click        css=.star.star-100
    Get Text     "Hodnocení bylo úspěšně uloženo."

Change a Star
    Click         css=.star.star-80
    Get Text     "Hodnocení bylo úspěšně uloženo."

Logout
    Click           css=.profile.initialized
    Get Variables   ${MENU_LOGGEDIN}
    Click           css=.dropdown-content.main-menu a[href="/odhlasit/"]
    Get Text        "Můj účet"


