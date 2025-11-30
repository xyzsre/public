#!/bin/bash

# MariaDB Backup and Restore Test Script
# This script tests creating a database, table, backing up, removing, and restoring.
# Assumes 'testuser' has necessary privileges (GRANT ALL on backup_test_db).
# Run with: ./mariadb_backup_restore_test.sh

echo "=== MariaDB Backup and Restore Test ==="
echo ""

# Step 1: Create a test database
echo "1. Creating test database 'backup_test_db'..."
mysql -u testuser -ptestuser -e "CREATE DATABASE IF NOT EXISTS backup_test_db;"
echo "   Description: Creates a database for testing backup and restore."
echo ""

# Step 2: Check database list
echo "2. Checking database list..."
mysql -u testuser -ptestuser -e "SHOW DATABASES;"
echo "   Description: Lists all databases to verify 'backup_test_db' exists."
echo ""

# Step 3: Create a table in the database
echo "3. Creating a table 'test_table' in 'backup_test_db'..."
mysql -u testuser -ptestuser backup_test_db -e "
CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    value INT
);
INSERT INTO test_table (name, value) VALUES ('BackupItem', 100);
SHOW TABLES;
DESCRIBE test_table;
"
echo "   Description: Creates a table with sample data and shows its structure."
echo ""

# Step 4: Backup the database
echo "4. Backing up the database 'backup_test_db'..."
mysqldump -u testuser -ptestuser backup_test_db > backup_test_db.sql
if [ $? -eq 0 ]; then
    echo "   Backup created: backup_test_db.sql"
else
    echo "   Error: Backup failed."
    exit 1
fi
echo "   Description: Uses mysqldump to create a SQL dump of the database."
echo ""

# Step 5: Remove the database
echo "5. Removing the database 'backup_test_db'..."
mysql -u testuser -ptestuser -e "DROP DATABASE backup_test_db;"
mysql -u testuser -ptestuser -e "SHOW DATABASES;"
echo "   Description: Drops the database to simulate data loss."
echo ""

# Step 6: Create the database again
echo "6. Recreating the database 'backup_test_db'..."
mysql -u testuser -ptestuser -e "CREATE DATABASE backup_test_db;"
mysql -u testuser -ptestuser -e "SHOW DATABASES;"
echo "   Description: Recreates the empty database."
echo ""

# Step 7: Check tables (should be empty)
echo "7. Checking tables in 'backup_test_db' (should be empty)..."
mysql -u testuser -ptestuser backup_test_db -e "SHOW TABLES;"
echo "   Description: Verifies the database is empty after recreation."
echo ""

# Step 8: Restore from backup
echo "8. Restoring the database from backup..."
mysql -u testuser -ptestuser backup_test_db < backup_test_db.sql
if [ $? -eq 0 ]; then
    echo "   Restore completed."
else
    echo "   Error: Restore failed."
    exit 1
fi
echo "   Description: Imports the SQL dump to restore the database."
echo ""

# Step 9: Check tables after restore
echo "9. Checking tables after restore..."
mysql -u testuser -ptestuser backup_test_db -e "
SHOW TABLES;
SELECT * FROM test_table;
"
echo "   Description: Verifies the table and data are restored."
echo ""

# Cleanup: Remove backup file
echo "Cleanup: Removing backup file..."
rm backup_test_db.sql
echo "   Backup file removed."
echo ""

echo "=== Test Completed ==="
echo "Backup and restore test successful!"
