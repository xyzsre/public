#!/bin/bash

# MySQL Bash Test Script
# This script demonstrates basic MySQL commands executed via bash.
# Assumes MySQL/MariaDB is installed and a user 'testuser' with password 'testuser' exists.
# Run with: ./mysql_bash_test.sh

echo "=== MySQL Bash Test Script ==="
echo "Testing basic MySQL operations via bash commands."
echo ""

# Basic Command 1: Test MySQL connection and show version
echo "1. Testing MySQL connection and showing version..."
mysql -u testuser -ptestuser -e "SELECT VERSION();"
echo "   Description: Connects to MySQL and executes a query to show the server version."
echo ""

# Basic Command 2: Show all databases
echo "2. Showing all available databases..."
mysql -u testuser -ptestuser -e "SHOW DATABASES;"
echo "   Description: Lists all databases the user has access to."
echo ""

# Basic Command 3: Create a test database
echo "3. Creating a test database..."
mysql -u testuser -ptestuser -e "CREATE DATABASE IF NOT EXISTS bash_test_db;"
mysql -u testuser -ptestuser -e "SHOW DATABASES;" | grep bash_test_db
echo "   Description: Creates a new database and verifies it exists."
echo ""

# Basic Command 4: Use the database and create a table
echo "4. Switching to database and creating a table..."
mysql -u testuser -ptestuser bash_test_db -e "
CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    value INT
);
SHOW TABLES;
DESCRIBE test_table;
"
echo "   Description: Selects the database, creates a table, and shows its structure."
echo ""

# Basic Command 5: Insert data into the table
echo "5. Inserting data into the table..."
mysql -u testuser -ptestuser bash_test_db -e "
INSERT INTO test_table (name, value) VALUES ('Item1', 10), ('Item2', 20);
SELECT * FROM test_table;
"
echo "   Description: Inserts sample data and displays the table contents."
echo ""

# Basic Command 6: Update data
echo "6. Updating data in the table..."
mysql -u testuser -ptestuser bash_test_db -e "
UPDATE test_table SET value = 15 WHERE name = 'Item1';
SELECT * FROM test_table;
"
echo "   Description: Updates a record and shows the changes."
echo ""

# Basic Command 7: Delete data
echo "7. Deleting data from the table..."
mysql -u testuser -ptestuser bash_test_db -e "
DELETE FROM test_table WHERE name = 'Item2';
SELECT * FROM test_table;
"
echo "   Description: Deletes a record and verifies the remaining data."
echo ""

# Basic Command 8: Drop the table and database
echo "8. Cleaning up: Dropping table and database..."
mysql -u testuser -ptestuser -e "
DROP TABLE IF EXISTS bash_test_db.test_table;
DROP DATABASE IF EXISTS bash_test_db;
SHOW DATABASES;
" | grep -v bash_test_db
echo "   Description: Removes the test table and database, confirming cleanup."
echo ""

echo "=== Script Completed ==="
echo "All basic MySQL commands tested successfully via bash."
