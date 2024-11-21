Muj Prvni Test
    ${output} =       Run          help dirs
    Log               ${output}

    Should Contain    ${output}    [+N]

Druhy Test
    ${output} =       Run          help abcs
    Log               ${output}

    Should Contain    ${output}    no help topics match