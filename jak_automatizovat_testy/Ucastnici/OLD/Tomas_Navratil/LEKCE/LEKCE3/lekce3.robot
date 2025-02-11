*** Settings ***
Library  Browser

*** Test Cases ***
Test1-Starting a browser with a page
    New Browser             chromium                                    headless=false
#    New Context            viewport={'width': 1920, 'height': 1080}
    New Page                http://testovani.kitner.cz/login
    Get Title               contains                            Testování
    Type Text               data-test=email_input              neco@nic.cz          #LOKATOR1  data-test

    sleep                   30

Test2-Starting a browser with a page        #vcetne loginu
    New Browser             chromium                                    headless=false
#    New Context            viewport={'width': 1920, 'height': 1080}
    New Page                http://testovani.kitner.cz/login

#    Type Text               data-test=email_input              neco@nic.cz          #LOKATOR2  id
    Type Text              id=email_input                       neco@nic.cz

#    click                   data-test=login_button
    click                   data-test=login_button

    sleep                   20


Test3-Starting a browser with a page
    New Browser             chromium                                    headless=false
#    New Context            viewport={'width': 1920, 'height': 1080}
    New Page                http://testovani.kitner.cz/login

#    Type Text               data-test=email_input              neco@nic.cz          #LOKATOR3- class

 #    Type Text                  class=input_box email border-[#E9EDF4] focus:border-[#bec0c2] w-full rounded-md border bg-white py-3 px-5 text-base text-body-color placeholder-[#ACB6BE] outline-none focus:border-primary focus-visible:shadow-none

     sleep                   20




