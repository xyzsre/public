# 3_create_database.py
# Description: Create a test database and verify.
# Installation Instructions:
# - Ensure Python 3 is installed: sudo apt install python3
# - Install pip if not present: sudo apt install python3-pip
# - Install MySQL connector: pip3 install mysql-connector-python
# pip3 install --break-system-packages mysql-connector-python

import mysql.connector

config = {
    'user': 'testuser',
    'password': 'testuser',
    'host': '127.0.0.1'
}

try:
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()
    cursor.execute("CREATE DATABASE IF NOT EXISTS python_test_db")
    print("Database 'python_test_db' created (if not exists).")

    # Verify
    cursor.execute("SHOW DATABASES")
    databases = [db[0] for db in cursor.fetchall()]
    if 'python_test_db' in databases:
        print("Verification: Database exists.")
    else:
        print("Verification: Database not found.")

    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")
