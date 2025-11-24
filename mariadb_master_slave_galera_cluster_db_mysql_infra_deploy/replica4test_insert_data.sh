#!/bin/bash
# MySQL connection details
MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASSWORD="P@ssw0rd"
MYSQL_DATABASE="replica4"
# Number of random names to insert
NUM_NAMES=1000
# Generate and insert random names
for ((i = 1; i <= NUM_NAMES; i++)); do
    # Generate a random name (replace with your own logic)
    RANDOM_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 8 | head -n 1)
    # SQL script content for insertion
    INSERT_SQL="INSERT INTO test (name) VALUES ('$RANDOM_NAME');"
    # Execute SQL script using the mysql command
    echo "$INSERT_SQL" | mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE
done
# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Inserted $NUM_NAMES random names into the test table successfully!"
else
    echo "Error inserting data. Check your MySQL connection details and try again."
fi
