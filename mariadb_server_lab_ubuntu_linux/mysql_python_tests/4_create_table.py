# 4_create_table.py
# Description: Switch to database, create a table, and show its structure.
# Installation Instructions:
# - Ensure Python 3 is installed: sudo apt install python3
# - Install pip if not present: sudo apt install python3-pip
# - Install MySQL connector: pip3 install mysql-connector-python
# pip3 install --break-system-packages mysql-connector-python

import mysql.connector

config = {
    'user': 'testuser',
    'password': 'testuser',
    'host': '127.0.0.1',
    'database': 'python_test_db'
}

try:
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()

    # Create table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS test_table (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(50),
            value INT
        )
    """)
    print("Table 'test_table' created.")

    # Show tables
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()
    print("Tables in database:")
    for table in tables:
        print(f"  - {table[0]}")

    # Describe table
    cursor.execute("DESCRIBE test_table")
    columns = cursor.fetchall()
    print("Table structure:")
    for col in columns:
        print(f"  {col[0]}: {col[1]}")

    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")

