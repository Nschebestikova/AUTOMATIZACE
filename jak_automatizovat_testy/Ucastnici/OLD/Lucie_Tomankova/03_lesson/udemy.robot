*** Settings ***
Library    Browser
Library    SeleniumLibrary
Documentation   Testing login and logout to udemy.com platform. Testing more possible selectors. Creating a keyword for login and logout, so that the test can be used universally for both, positive and negative scenarios. Challenging myself how to automate Verification that I'm a human in a new redirected window and than getting back to the original window.
#lu.tom@email.cz        Testing.999


*** Test Cases ***
Login and logout on Udemy platform
    #opening the browser and the webpage
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.udemy.com/?utm_source=adwords-brand&utm_medium=udemyads&utm_campaign=Brand-Udemy_la.EN_cc.ROWMTA-A&utm_term=_._ag_80979681354_._ad_534056438135_._de_c_._dm__._pl__._ti_kwd-296956216253_._li_9062901_._pd__._&utm_term=_._pd__._kw_udemy_._&matchtype=b&gclid=EAIaIQobChMIq5vt9LXH_gIVoQQGAB3LjwFKEAAYASAAEgL1B_D_BwE
    #test if it was ok
    Sleep    3s
    ${text}    Browser.Get Title      ==    Online Courses - Learn Anything, On Your Schedule | Udemy
    Should Be Equal    ${text}     Online Courses - Learn Anything, On Your Schedule | Udemy
    Take Screenshot

    #allowing all cookies
    Click       id=onetrust-accept-btn-handler
    Sleep    1s
    #test if it was ok
    Take Screenshot

    #click the login button
    Click       xpath=//*[@data-purpose='header-login']
    Take Screenshot
    Sleep    3s

    #verify if I'm a human - toto ještě nefunguje
    Click      xpath=//*[@class="mark"]
    Open Browser        https://www.udemy.com/join/login-popup/?locale=en_US&response_type=html&next=https%3A%2F%2Fwww.udemy.com%2F%3Futm_source%3Dadwords-brand%26utm_medium%3Dudemyads%26utm_campaign%3DBrand-Udemy_la.EN_cc.ROWMTA-A%26utm_term%3D_._ag_80979681354_._ad_534056438135_._de_c_._dm__._pl__._ti_kwd-296956216253_._li_9062901_._pd__._%26utm_term%3D_._pd__._kw_udemy_._%26matchtype%3Db%26gclid%3DEAIaIQobChMIq5vt9LXH_gIVoQQGAB3LjwFKEAAYASAAEgL1B_D_BwE         chrome
    Switch Window       title=Just a moment...
    #tady si nejsem jista selektorem, v Chromu se mi blbe overuji selektory. Právě jsem instalovala selectorGadget, ale ještě mi to nejede.
    Wait Until Element Is Visible       css=[class="mark"]
    Click Element       css=[class="mark"]
    Close Window
    Take Screenshot



#    #test if it was ok
#    Get Text        id=auth-to-udemy-title        ==      Log in to your Udemy account
#    Take Screenshot



