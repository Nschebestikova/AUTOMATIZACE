*** Settings ***
Library    Browser
Documentation   Testing login and logout into testovani.kitner.cz application. Testing more possible selectors. Creating a keyword for login and logout, so that the test can be used universally for both, positive and negative scenarios.


*** Test Cases ***
Positive test - login and logout with correct credentials
    Login and log out              lu.tom@email.cz          Testing.111            Vítej uživateli Lucie Tománková!        Přihlášení
Negative test - login and logout with an incorrect email
    Login and log out              lu.tom@email.com          Testing.111            Vítej uživateli Lucie Tománková!        Přihlášení
Negative test - login and logout with an incorrect password
    Login and log out              lu.tom@email.cz          Testing.123            Vítej uživateli Lucie Tománková!        Přihlášení


*** Keywords ***
Login and log out
    [Arguments]     ${email}      ${password}     ${checkLogin}     ${checkLogout}
    #opening the browser and the webpage
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       http://testovani.kitner.cz/login
    #test if it was ok
    ${title}    Get Title      ==    Testování
    Should Be Equal    ${title}     Testování

    #login with email and password
    Type Text      data-test=email_input    ${email}
    Type Text      data-test=password_input     ${password}

    #click the log in button
    #Click          data-test=login_button  #this works ok, just testing other possible selectors
    #Click          css=[class="mb-10"]  #also works ok
    Click           text=Přihlásit  #also works ok, but of course data-test is the best solution
    #test if it was ok
    Sleep    3s
    Take Screenshot
    ${checkLogin} =   Get Text      data-test=home_section     ==      Vítej uživateli Lucie Tománková!

    #click the log out button
    Click          data-test=logout_button
    #test if it was ok
    Take Screenshot
    ${checkLogout} =    Get Text       data-testid=login_text       ==      Přihlášení
