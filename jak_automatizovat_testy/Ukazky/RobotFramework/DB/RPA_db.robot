"""
Tento příklad potřebuje:
pip install rpaframework-core
"""

*** Settings ***
Library         RPA.Database


*** Variables ***
${DBHost}         replikant2561.thinline.cz
${DBName}         kitnercz02
${DBPass}         XzLY204zz
${DBPort}         3755
${DBUser}         kitnercz003@127.0.0.1


*** Tasks ***
Get Orders From Database
    Connect To Database  pymysql  tester  user  password  127.0.0.1
    @{orders}            Query    Select * FROM incoming_orders
    FOR   ${order}  IN  @{orders}
        Handle Order  ${order}
    END