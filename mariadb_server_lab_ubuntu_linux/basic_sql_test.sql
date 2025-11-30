-- Basic SQL Commands Test File
-- This file contains step-by-step basic SQL commands for testing MariaDB/MySQL.
-- Run this file with: mysql -u testuser -ptestuser < basic_sql_test.sql
-- Or execute line by line in MySQL client.

-- Step 1: Check current databases
-- Description: List all available databases to see what's already there.
SHOW DATABASES;

-- Verification: You should see databases like 'information_schema', 'mysql', etc.

-- Step 2: Create a new database
-- Description: Create a test database named 'testdb'.
CREATE DATABASE IF NOT EXISTS testdb;

-- Verification: Check if 'testdb' appears in the database list.
SHOW DATABASES;

-- Step 3: Switch to the new database
-- Description: Use the 'testdb' database for subsequent operations.
USE testdb;

-- Verification: Check current database.
SELECT DATABASE();

-- Step 4: Show tables in the current database
-- Description: List all tables (should be empty initially).
SHOW TABLES;

-- Verification: No tables should be listed yet.

-- Step 5: Create a table
-- Description: Create a simple 'users' table with columns: id (auto-increment), name, email, age.
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT
);

-- Verification: Check if 'users' table is created.
SHOW TABLES;
DESCRIBE users;

-- Step 6: Insert data into the table
-- Description: Insert sample data into the 'users' table.
INSERT INTO users (name, email, age) VALUES
('John Doe', 'john@example.com', 25),
('Jane Smith', 'jane@example.com', 30),
('Bob Johnson', 'bob@example.com', 22);

-- Verification: Select all data to confirm insertion.
SELECT * FROM users;

-- Step 7: Select data with filtering
-- Description: Select users older than 24.
SELECT * FROM users WHERE age > 24;

-- Verification: Should show John and Jane.

-- Step 8: Update data
-- Description: Update John's age to 26.
UPDATE users SET age = 26 WHERE name = 'John Doe';

-- Verification: Check the updated data.
SELECT * FROM users WHERE name = 'John Doe';

-- Step 9: Select data with sorting
-- Description: Select all users sorted by age in descending order.
SELECT * FROM users ORDER BY age DESC;

-- Verification: Bob (22), Jane (30), John (26).

-- Step 10: Select specific columns
-- Description: Select only name and email from users.
SELECT name, email FROM users;

-- Verification: Should show name and email columns only.

-- Step 11: Use aggregate functions
-- Description: Count the number of users.
SELECT COUNT(*) AS total_users FROM users;

-- Verification: Should show 3.

-- Step 12: Use LIKE for pattern matching
-- Description: Find users whose email ends with 'example.com'.
SELECT * FROM users WHERE email LIKE '%example.com';

-- Verification: All users.

-- Step 13: Delete data
-- Description: Delete Bob's record using ID (more reliable for testing).
DELETE FROM users WHERE id = 3;

-- Verification: Check remaining users.
SELECT * FROM users;

-- Step 14: Alter table (add a column)
-- Description: Add a 'created_at' column to the users table.
ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Verification: Check table structure.
DESCRIBE users;

-- Step 15: Insert more data to test the new column
-- Description: Insert a new user.
INSERT INTO users (name, email, age) VALUES ('Alice Brown', 'alice@example.com', 28);

-- Verification: Select all to see the timestamp.
SELECT * FROM users;

-- Step 16: Use GROUP BY
-- Description: Group users by age and count.
SELECT age, COUNT(*) AS count FROM users GROUP BY age;

-- Verification: Shows age groups.

-- Step 17: Drop the table
-- Description: Remove the 'users' table.
DROP TABLE IF EXISTS users;

-- Verification: Check tables (should be empty).
SHOW TABLES;

-- Step 18: Drop the database
-- Description: Remove the 'testdb' database.
DROP DATABASE IF EXISTS testdb;

-- Verification: Check databases (testdb should be gone).
SHOW DATABASES;

-- End of basic SQL test.
-- Note: This covers creation, insertion, updating, selecting, filtering, sorting, aggregation, and deletion.
