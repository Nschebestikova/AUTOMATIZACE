*** Settings ***
# instalace:      pip install robotframework-databaselibrary
# Dokumentace ke knihovně: https://marketsquare.github.io/Robotframework-Database-Library/#library-documentation-top
#                          https://github.com/MarketSquare/Robotframework-Database-Library

Library           DatabaseLibrary

Suite Setup       Pripojeni k DB
Suite Teardown    Uklid

*** Variables ***
${DB_PATH}        mojedb.db

*** Test Cases ***
Zakladni test pro DB
    # Výpis všech tabulek v DB
    # DOPLŇENÍ: Klíčové slovo Query se používá pro provádění SQL dotazů, které očekávají návratová data, jako jsou SELECT příkazy.
    ${tables}=    Query    SELECT name FROM sqlite_master WHERE type='table'

    # Vytvoření tabuky Zbozi
    Query  CREATE TABLE Zbozi (ID INTEGER PRIMARY KEY AUTOINCREMENT, Nazev TEXT NOT NULL, Cena REAL NOT NULL, Skladem INTEGER NOT NULL);

   # Přidání zboží/položky do tabulky Zbozi
    Execute Sql String    INSERT INTO Zbozi (Nazev, Cena, Skladem) VALUES ('Mikrovlnka', 3000, 15)
    Execute Sql String    INSERT INTO Zbozi (Nazev, Cena, Skladem) VALUES ('Lednice', 8000, 10)
    # DOPLŇENÍ: Klíčové slovo Execute Sql String se používá pro provádění SQL příkazů, které nevrací data, jako jsou INSERT, UPDATE, DELETE, a DDL operace (např. CREATE TABLE, DROP TABLE).

    # Výpis všech záznamů v tabulce Zbozi
    ${items}=    Query    SELECT ID, Nazev, Cena, Skladem FROM Zbozi
    Log    Items in Zbozi: ${items}


    #Kontrola obsahu tabulkly
    @{query_result}    Query    SELECT * FROM Zbozi
    Log    ${query_result}
    Log To Console    ${query_result}
    Should Contain    ${query_result}[0][1]    Mikrovlnka
    Should Contain    ${query_result}[1][1]    Lednice


*** Keywords ***
Pripojeni k DB
    Connect To Database Using Custom Params  sqlite3  database="./mojedb.db", isolation_level=None
#    Connect To Database  dbapiModuleName=pymysql  dbName=mojedb  dbUsername=yourusername  dbPassword=yourpassword  dbHost=mojedb.db  dbPort=3755


Uklid
    # Smazání tabulky Zbozi
    Execute Sql String    DROP TABLE Zbozi
    # Odpojení od DB
    Disconnect From Database







