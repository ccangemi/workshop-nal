@echo off
echo Initializing MariaDB database...

oc exec -it mariadb-0 -- mariadb -u root -pworkshop123 workshop_db -e "CREATE TABLE ORDERS (OrderId INT AUTO_INCREMENT PRIMARY KEY, OrderData TEXT NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP); INSERT INTO ORDERS (OrderData) VALUES ('Sample order 1'), ('Sample order 2');"

if %ERRORLEVEL% EQU 0 (
    echo Database initialized successfully!
    echo Verifying table creation...
    oc exec -it mariadb-0 -- mariadb -u root -pworkshop123 workshop_db -e "SHOW TABLES; SELECT * FROM ORDERS;"
) else (
    echo Failed to initialize database. Error code: %ERRORLEVEL%
)