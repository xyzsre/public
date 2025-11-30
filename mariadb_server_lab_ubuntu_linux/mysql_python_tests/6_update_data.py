# 6_update_data.py
# Description: Update data in the table and show changes.

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

    # Update data
    cursor.execute("UPDATE test_table SET value = %s WHERE name = %s", (15, 'Item1'))
    conn.commit()
    print("Data updated.")

    # Select and display
    cursor.execute("SELECT * FROM test_table")
    rows = cursor.fetchall()
    print("Updated table contents:")
    for row in rows:
        print(f"  ID: {row[0]}, Name: {row[1]}, Value: {row[2]}")

    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")
