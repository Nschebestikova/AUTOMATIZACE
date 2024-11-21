*** Settings ***
Library               RequestsLibrary

*** Variables ***


*** Test Cases ***
test demo
    Ukazka logovani

*** Keywords ***
Ukazka logovani
# urovně logování: TRACE, DEBUG, INFO (default), HTML, WARN, ERROR

    Log                     Ahoj
    Log                     Tohle je chyba!             ERROR
    Log                     Warning!                    WARN
    Log                     Info!                       INFO
    Log                     Debugggg!                   DEBUG
    Log                     Traceeee!                   TRACE
    Log	                    Heslo je: tajne\x00
    Log	                    Heslo je: tajne\x00         formatter=repr

    Log Variables

    @{list1} =  Create List             first  second  third

    @{dict1} =  Create Dictionary       key=value   foo=bar

# do příkazové řádky napíši:
#    robot -L TRACE ./DSL8.robot