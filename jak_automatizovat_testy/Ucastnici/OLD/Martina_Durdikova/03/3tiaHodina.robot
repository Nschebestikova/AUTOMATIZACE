*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
  New Browser  chromium    headless=false
  New Page  https://marketsquare.github.io/robotframework-browser/Browser.html
  Get Title  ==  Browser

Starting a browser with a page headless mode
  New Browser  chromium  headless=true
  New Page  https://google.com
  Get Title  ==  Google

Starting a browser with a page w/o headless mode with sleep
  New Browser  chromium  headless=false
  New Page  https://google.com
  Sleep    2s
  Get Title  ==  Google