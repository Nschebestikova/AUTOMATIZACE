*** Settings ***
Documentation  Simple example using AppiumLibrary
Library  AppiumLibrary



*** Test Cases ***
Spusteni Chromu na mobilu
  Open Test Application
#  Input Search Query  Hello World!
#  Submit Search
#  Search Query Should Be Matching  Hello World!


*** Keywords ***
#Před spuštením testu je nutné ručně spusti appium server z CMD
Open Test Application

#  Open Application  http://192.168.1.131:4723
#  ...  platformName=Android  deviceName=R5CT90PH6ZK  automationName=uiautomator2
#  ...  appPackage=cz.alza.media  appActivity=cz.alza.base.android.setup.ui.activity.MainActivity

  Open Application  http://192.168.1.131:4723
  ...  platformName=Android  deviceName=emulator-5554  automationName=uiautomator2
  ...  appPackage=com.android.chrome  appActivity=com.google.android.apps.chrome.IntentDispatcher

Input Search Query
    [Arguments]  ${query}
    # Přidejte příslušné lokátory a metody pro zadání textu do vyhledávacího pole v Chrome
    Click Element  id=terms_accept
    Click Element  id=negative_button
    Click Element  id=search_box_text
    Input Text     id=search_box_text  ${query}


#Input Search Query
#  [Arguments]  ${query}
#  Input Text  txt_query_prefill  ${query}
#
#Submit Search
#  Click Element  btn_start_search
#
#Search Query Should Be Matching
#  [Arguments]  ${text}
#  Wait Until Page Contains Element  android:id/search_src_text
#  Element Text Should Be  android:id/search_src_text  ${text}