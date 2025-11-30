# 7_delete_data.py
# Description: Delete data from the table and verify.

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

    # Delete data
    cursor.execute("DELETE FROM test_table WHERE name = %s", ('Item2',))
    conn.commit()
    print("Data deleted.")

    # Select and display
    cursor.execute("SELECT * FROM test_table")
    rows = cursor.fetchall()
    print("Remaining table contents:")
    for row in rows:
        print(f"  ID: {row[0]}, Name: {row[1]}, Value: {row[2]}")

    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")
