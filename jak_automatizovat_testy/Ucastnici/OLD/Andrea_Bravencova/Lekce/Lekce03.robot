*** Settings ***
Library  Browser
#     odted vse spoustet takhle andrejka@Andrea-MBP ~ % open -na "PyCharm CE.app"
*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page         https://marketsquare.github.io/robotframework-browser/Browser.html
    Get Title      ==    Browser

