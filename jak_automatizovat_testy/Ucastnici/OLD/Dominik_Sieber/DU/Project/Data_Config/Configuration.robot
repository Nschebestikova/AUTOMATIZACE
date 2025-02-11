#*** Variables ***
# Tento soubor obsahuje všechny konfigurační parametry a proměné
#

*** Variables ***
${URL}                      http://testovani.kitner.cz/courses
${Browser} =                chromium
#${HeadLess_FLS} =           headless=False


${Time_Btwn_Clicks}         200ms
${Time_Btwn_Checkcs}        500ms

${SleepBeforeTest}          2 s

${TimeOut_Browser}          10 s
${TC_TIMEOUT_ROBOT_KW}      2 minutes