# 2_show_databases.py
# Description: Show all available databases.
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
    cursor.execute("SHOW DATABASES")
    databases = cursor.fetchall()
    print("Databases:")
    for db in databases:
        print(f"  - {db[0]}")
    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")
