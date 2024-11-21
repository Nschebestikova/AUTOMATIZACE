*** Settings ***
Library        Browser
Documentation
Resource       TestDataProject.robot
Resource       ConfigurationProjekt.robot
Library        RequestsLibrary
Library        String

Test Setup          Start Task
Suite Setup         Browser Start
Test Teardown       Logout
Suite Teardown      End Suite

*** Test Cases ***
Should check successful log in and log out
    PositiveLogin           ${USER1_USERNAME}        ${USER1_PASSWORD}       LoggedIn
    Sleep    5

Should check unsuccessful log in
    Missing Password        ${USER2_USERNAME}        NotLoggedIn
    NegativeLogin           ${USER2_USERNAME}        ${USER2_PASSWORD}       NotLoggedIn
    Sleep    5
   [Teardown]    SKIP  # v tomto testu nechci aplikovat Test Teardown, protoze nejsem prihlasena

Should add movie a star
    PositiveLogin           ${USER1_USERNAME}        ${USER1_PASSWORD}       LoggedIn
    Search for movie        ${MOVIE_SvetPodleProta}
    Change a Star           ${MOVIE_SvetPodleProta}

Should control dropdown API data after movie is searched     #naseptavac
    PositiveLogin           ${USER1_USERNAME}        ${USER1_PASSWORD}       LoggedIn
    Search for movie        ${MOVIE_MujSousedTotoro}
    API Comunication        {'films': [{'name': 'Můj soused Totoro', 'search_name': None, 'year': 1988, 'rating_icon_class': 'red', 'link': 'https://www.csfd.cz/film/42137-muj-soused-totoro/'}, {'name': 'Můj soused zabiják', 'search_name': None, 'year': 2000, 'rating_icon_class': 'red', 'link': 'https://www.csfd.cz/film/16737-muj-soused-zabijak/'}, {'name': 'Můj soused rocker', 'search_name': None, 'year': 2014, 'rating_icon_class': 'blue', 'link': 'https://www.csfd.cz/film/389766-muj-soused-rocker/'}, {'name': 'Můj soused zabiják 2', 'search_name': None, 'year': 2004, 'rating_icon_class': 'blue', 'link': 'https://www.csfd.cz/film/42998-muj-soused-zabijak-2/'}, {'name': 'Můj soused Hitler', 'search_name': None, 'year': 2012, 'rating_icon_class': 'red', 'link': 'https://www.csfd.cz/film/619768-muj-soused-hitler/'}, {'name': 'Mój sąsiad Adolf', 'search_name': 'Môj sused Adolf', 'year': 2022, 'rating_icon_class': 'blue', 'link': 'https://www.csfd.cz/film/1217462-moj-sused-adolf/'}, {'name': 'Môj sused Erwin', 'search_name': None, 'year': 2017, 'rating_icon_class': 'lightgrey', 'link': 'https://www.csfd.cz/film/512960-moj-sused-erwin/'}, {'name': 'Sousedé mých sousedů', 'search_name': None, 'year': 2021, 'rating_icon_class': 'blue', 'link': 'https://www.csfd.cz/film/1143898-sousede-mych-sousedu/'}, {'name': 'Soused Abdi', 'search_name': None, 'year': 2022, 'rating_icon_class': 'lightgrey', 'link': 'https://www.csfd.cz/film/1221284-soused-abdi/'}, {'name': 'Soused', 'search_name': None, 'year': 1993, 'rating_icon_class': 'blue', 'link': 'https://www.csfd.cz/film/16196-soused/'}], 'series': [{'name': 'Můj drahý soused', 'search_name': None, 'year': 2018, 'rating_icon_class': 'red', 'link': 'https://www.csfd.cz/film/597530-muj-drahy-soused/'}, {'name': 'Můj drahý soused - Epizoda 1', 'search_name': None, 'year': 2018, 'rating_icon_class': 'lightgrey', 'link': 'https://www.csfd.cz/film/597530-muj-drahy-soused/943581-epizoda-1/'}, {'name': 'Můj drahý soused - Epizoda 6', 'search_name': None, 'year': 2018, 'rating_icon_class': 'lightgrey', 'link': 'https://www.csfd.cz/film/597530-muj-drahy-soused/943586-epizoda-6/'}, {'name': 'Můj drahý soused - Epizoda 7', 'search_name': None, 'year': 2018, 'rating_icon_class': 'lightgrey', 'link': 'https://www.csfd.cz/film/597530-muj-drahy-soused/943587-epizoda-7/'}, {'name': 'Můj drahý soused - Epizoda 8', 'search_name': None, 'year': 2018, 'rating_icon_class': 'lightgrey', 'link': 'https://www.csfd.cz/film/597530-muj-drahy-soused/943588-epizoda-8/'}], 'creators': [{'name': 'Juha Muje', 'info': 'herec, nar. 1950', 'search_name': None, 'link': 'https://www.csfd.cz/tvurce/115301-juha-muje/'}, {'name': 'Jakup Muja', 'info': 'herec', 'search_name': None, 'link': 'https://www.csfd.cz/tvurce/711836-jakup-muja/'}, {'name': 'Severi Muje', 'info': 'herec', 'search_name': None, 'link': 'https://www.csfd.cz/tvurce/233457-severi-muje/'}, {'name': 'Samuli Muje', 'info': 'herec, nar. 1974', 'search_name': None, 'link': 'https://www.csfd.cz/tvurce/159677-samuli-muje/'}, {'name': 'Mujo Masinde', 'info': 'režisér', 'search_name': None, 'link': 'https://www.csfd.cz/tvurce/270309-mujo-masinde/'}], 'users': [{'nick': 'Rudolf.Benes', 'fullname': 'Soused 1976', 'link': 'https://www.csfd.cz/uzivatel/627313-rudolf-benes/'}, {'nick': 'mujvi', 'fullname': '', 'link': 'https://www.csfd.cz/uzivatel/887674-mujvi/'}, {'nick': 'Soused77', 'fullname': '', 'link': 'https://www.csfd.cz/uzivatel/914469-soused77/'}]}  200  q=Muj%20soused


*** Keywords ***

Browser Start
    ${b_timeput} =     Set Browser Timeout                 ${TIMEOUT_BROWSER}
    New Browser     ${BROWSER}    headless=false
    New Page        ${URL_Main}
    Click           ${SEL_AcceptCookies}
    Get Title      ==    ${TEXT_MainTitle}

GoToLogin
    Click           ${TEXT_Menu}
    Get Variables   ${MENU_NOT_LOGGEDIN}
    Go To           ${LOG_IN_PAGE}
    Get Text        ${TEXT_LoginPage}

PositiveLogin
    GoToLogin
    [Arguments]     ${USER1_USERNAME}   ${USER1_PASSWORD}   ${text}
    Type Text       ${SEL_loginFormUsername}   ${USER1_USERNAME}
    Type Text       ${SEL_loginFormPasssword}  ${USER1_PASSWORD}
    Click           ${SEL_SubmitBtn}
    IF    "${text}" == "LoggedIn"
       Get Text          ${TEXT_LoggedIn}
       Log To Console    ${LOG_UserLoggedIn}
    ELSE
       Log To Console    ${LOG_PageFailed}
    END

NegativeLogin
    GoToLogin
    [Arguments]     ${USER2_USERNAME}  ${USER2_PASSWORD}  ${text}
    Type Text       ${SEL_loginFormUsername}  ${USER2_USERNAME}
    Type Text       ${SEL_loginFormPasssword}  ${USER2_PASSWORD}
    Click           ${SEL_SubmitBtn}
    IF    "${text}" == "NotLoggedIn"
        Get Text          ${SEL_WrongCredentials}  *=   ${TEXT_CredentialsFailed}
        Log To Console    ${LOG_UserNotLoggedIn}
        End Task
    ELSE
        Log To Console    ${LOG_PageFailed}
    END

Missing Password
    GoToLogin
    [Arguments]     ${USER2_USERNAME}  ${text}
    Type Text       ${SEL_loginFormUsername}  ${USER2_USERNAME}
    Click           ${SEL_SubmitBtn}
    Get Text        ${SEL_loginMissPasssword}  *=  ${TEXT_MissPassword}
    Log to console  ${LOG_UserNotLoggedIn}

Search for movie
    [Arguments]     ${MOVIE}
    Type Text       ${SEL_SearchInput}  ${MOVIE}

Change a Star
    [Arguments]     ${MOVIE}
    Click           ${SEL_SearchBtn}
    Click           "${MOVIE}"
    Click           ${SEL_star-100}
    Get Text        ${TEXT_ReviewAdded}
    Click           ${SEL_star-80}
    Get Text        ${TEXT_ReviewAdded}

Logout
    Click           ${SEL_MenuStart}
    Get Variables   ${MENU_LOGGEDIN}
    Click           ${SEL_LogOutBtn}
    Get Text        ${TEXT_Menu}

Start Task
   Go To              ${URL_Main}

End Task
   Go To              ${URL_Main}

End Suite
  Close Browser


API Comunication
    [Arguments]        ${json}     ${error_resp}  ${params}
    &{header}=         Create Dictionary   Accept=application/json  x-requested-with=XMLHttpRequest   charset=utf-8  user-agent=Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Mobile Safari/537.36
    ${resp} =          GET  ${urlapp}      params=${params}    expected_status=${error_resp}  headers=${header}
    Status Should Be    ${error_resp}

      Log To Console  ${resp.ok}
      Log To Console  ${resp.status_code}
      Log To Console  ${resp.reason}
      Log To Console  ${resp.json()}


#    ${name}=  ${resp.json()}[1]}                 #snazila jsem se projit pole a vyhledat jmeno prvniho filmu v listu a porovnat, jestli sedi s vyhledavanym jmenem
#    Should Be Equal As Strings   ${json}   ${resp.json()}