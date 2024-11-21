*** Settings ***
Library  RequestsLibrary


*** Test Cases ***
Quick Get A JSON Body Test - catfact
      ${response}=    GET  https://catfact.ninja/fact

      Log To Console   ${response.json()}[fact]
      Log To Console   ${response.json()}[length]

Quick Get A JSON Body Test - dogs
      ${response}=    GET  https://dog.ceo/api/breeds/image/random

      Log To Console   ${response.json()}[message]
      Log To Console   ${response.json()}[status]

Quick Get A JSON Body Test - ipinfo
      ${response}=    GET  https://ipinfo.io/161.185.160.93/geo

      Log To Console   ${response.json()}[ip]
      Log To Console   ${response.json()}[timezone]

Quick Get A JSON Body Test - jokes
      ${response}=    GET  https://official-joke-api.appspot.com/random_joke

      Log To Console   ${response.json()}[setup]
      Log To Console   ${response.json()}[punchline]


#///////////////////////////////////////////////////////
#Pokud je json formát nested, jak získat tuto vnořenou hodnotu?
Quick Get A JSON Body Test - randomuser
      ${response}=    GET  https://randomuser.me/api/

      Log To Console   ${response.json()}[results][0][gender]
      Log To Console   ${response.json()}[results][0][name][title]
      Log To Console   ${response.json()}[results][0][name][first]
      Log To Console   ${response.json()}[results][0][name][last]
      Log To Console   ${response.json()}[results][0][picture][large]

      Log To Console   ${response.json()}[info][seed]
      Log To Console   ${response.json()}[info][version]




