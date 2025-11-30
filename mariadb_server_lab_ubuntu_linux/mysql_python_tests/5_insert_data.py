# 5_insert_data.py
# Description: Insert data into the table and display contents.

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

    # Insert data
    cursor.execute("INSERT INTO test_table (name, value) VALUES (%s, %s)", ('Item1', 10))
    cursor.execute("INSERT INTO test_table (name, value) VALUES (%s, %s)", ('Item2', 20))
    conn.commit()
    print("Data inserted.")

    # Select and display
    cursor.execute("SELECT * FROM test_table")
    rows = cursor.fetchall()
    print("Table contents:")
    for row in rows:
        print(f"  ID: {row[0]}, Name: {row[1]}, Value: {row[2]}")

    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")
