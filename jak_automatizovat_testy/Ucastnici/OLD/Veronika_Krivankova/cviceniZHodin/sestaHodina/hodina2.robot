*** Settings ***
Library               RequestsLibrary

*** Test Cases ***
Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
      Log To Console    >>>>>>>>>${response.json()}<<<<<<<<<<
