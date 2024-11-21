*** Settings ***
Library  OperatingSystem

*** Variables ***
${output_text}=  ASSOC
${output_text1}=  Volume Serial Number is
${output_text2}=  is not recognized
${output_text3}=  is not recognized

*** Test Cases ***

test na prikaz dir - 1.pozitivni
    ${output}=  Run    help
    Should contain    ${output}   ${output_text}
    Log               Prikaz help obsahuje tento text: ${output_text}

test na prikaz dir - 2.pozitivni
    ${output} =  Run    vol
    Should Contain    ${output}    ${output_text1}
    Log               Prikaz vol bsahuje tento text: ${output_text1}

test na prikaz dir - 1.negativni
    ${output} =  Run    neexist
    Should Contain    ${output}    ${output_text2}
    Log               prikaz: ${output_text2} nelze najit

test na prikaz dir - 2.negativni
    ${output} =  Run    dirs
    Should Contain    ${output}    ${output_text3}
    Log               prikaz: ${output_text3} nelze najit