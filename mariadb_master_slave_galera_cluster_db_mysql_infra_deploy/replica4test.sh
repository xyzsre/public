#!/bin/bash
# MySQL connection details
MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASSWORD="P@ssw0rd"
MYSQL_DATABASE="replica4"
# SQL script content
SQL_SCRIPT=$(cat <<EOL
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
USE $MYSQL_DATABASE;
CREATE TABLE IF NOT EXISTS test (
    name VARCHAR(18)
);
EOL
)
# Execute SQL script using the mysql command
echo "$SQL_SCRIPT" | mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD
# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Database $MYSQL_DATABASE and table test created successfully!"
else
    echo "Error creating database and table. Check your MySQL connection details and try again."
fi
