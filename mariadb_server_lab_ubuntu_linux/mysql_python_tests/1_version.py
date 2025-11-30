# 1_version.py
# Description: Test MySQL connection and show server version.
# Installation Instructions:
# - Ensure Python 3 is installed: sudo apt install python3
# - Install pip if not present: sudo apt install python3-pip
# - Install MySQL connector: pip3 install mysql-connector-python
# pip3 install --break-system-packages mysql-connector-python

import mysql.connector

# Connection details (adjust as needed)
config = {
    'user': 'testuser',
    'password': 'testuser',
    'host': '127.0.0.1',
    'database': None  # No database for version check
}

try:
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()
    cursor.execute("SELECT VERSION()")
    version = cursor.fetchone()
    print(f"MySQL Version: {version[0]}")
    cursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error: {err}")
