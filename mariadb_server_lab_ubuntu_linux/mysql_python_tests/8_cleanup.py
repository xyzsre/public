# 8_cleanup.py
# Description: Drop the table and database for cleanup.

import mysql.connector

config = {
    'user': 'testuser',
    'password': 'testuser',
    'host': '127.0.0.1'
}

try:
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()

    # Drop table
    cursor.execute("DROP TABLE IF EXISTS python_test_db.test_table")
    print("Table dropped.")

    # Drop database
    cursor.execute("DROP DATABASE IF EXISTS python_test_db")
    print("Database dropped.")

    # Verify
    cursor.execute("SHOW DATABASES")
    databases = [db[0] for db in cursor.fetchall()]
    if 'python_test_db' not in databases:
        print("Verification: Database and table removed.")
    else:
        print("Verification: Database still exists.")

    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")
