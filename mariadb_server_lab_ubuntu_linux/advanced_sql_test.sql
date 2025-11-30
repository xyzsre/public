-- Advanced SQL Test File
-- This file demonstrates advanced but simple SQL features: data generation, indexing, views, full-text search, and performance testing.
-- Run with: mysql -u testuser -ptestuser < advanced_sql_test.sql

-- Step 1: Create database
-- Description: Create a database for advanced testing.
-- Why: To isolate test data and demonstrate database creation.
CREATE DATABASE IF NOT EXISTS advanced_test_db;
SHOW DATABASES;
USE advanced_test_db;

-- Verification: Check database created.
SHOW DATABASES;
SELECT DATABASE();

-- Step 2: Create users table
-- Description: Table with user info including age, department, salary for grouping and analysis.
-- Why: Supports aggregation, indexing, and search operations.
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- Verification: Check table structure.
DESCRIBE users;
SHOW TABLES;

-- Step 3: Create stored procedure to generate random user data
-- Description: Procedure to insert random users (100 initially, then 1000).
-- Why: Automates data insertion for testing at scale; demonstrates procedures and loops.
DELIMITER //

CREATE PROCEDURE generate_users(IN num_users INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE base INT DEFAULT FLOOR(UNIX_TIMESTAMP() + (RAND() * 1000000)); -- Timestamp + random for high uniqueness
    DECLARE rand_name VARCHAR(100);
    DECLARE rand_email VARCHAR(100);
    DECLARE rand_age INT;
    DECLARE rand_dept VARCHAR(50);
    DECLARE rand_salary DECIMAL(10,2);

    WHILE i <= num_users DO
        SET rand_name = CONCAT('User', base + i);
        SET rand_email = CONCAT('user', base + i, '@example.com');
        SET rand_age = FLOOR(RAND() * 40) + 20; -- Age 20-59
        SET rand_dept = ELT(FLOOR(RAND() * 4) + 1, 'IT', 'HR', 'Finance', 'Marketing');
        SET rand_salary = ROUND(RAND() * 50000 + 30000, 2); -- Salary 30000-80000

        INSERT INTO users (name, email, age, department, salary) VALUES (rand_name, rand_email, rand_age, rand_dept, rand_salary);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

-- Verification: List procedures to confirm creation.
SHOW PROCEDURE STATUS WHERE Db = DATABASE() AND Name = 'generate_users';

-- Optional: To remove the procedure later, uncomment the line below.
-- DROP PROCEDURE IF EXISTS generate_users;
-- Description: Call procedure to insert 100 random users.
-- Why: Creates test data for initial analysis.
CALL generate_users(100);

-- Verification: Check row count and sample data.
SELECT COUNT(*) AS total_users FROM users;
SELECT * FROM users LIMIT 5;
-- To view all generated data, use (caution: large output):
SELECT * FROM users ORDER BY id LIMIT 100;  -- Adjust LIMIT as needed
-- Full select (uncomment if needed, but may be overwhelming):
-- SELECT * FROM users;

-- Optional: Delete all users after verification (uncomment to clean up)
-- TRUNCATE TABLE users;  -- Faster way to remove all data and reset auto-increment
-- Alternative: DELETE FROM users;
-- Verification after delete: SELECT COUNT(*) FROM users;  -- Should be 0

-- Step 5: Group and aggregate data
-- Description: Group by department and calculate min/max/avg salary and age, count users.
-- Why: Demonstrates GROUP BY, aggregate functions for data analysis.
SELECT
    department,
    COUNT(*) AS num_users,
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    AVG(age) AS avg_age,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    AVG(salary) AS avg_salary
FROM users
GROUP BY department;

-- Verification: Should show aggregates per department.

-- Step 6: Create views for common queries
-- Description: Views for salary stats, age stats, and department user counts.
-- Why: Views simplify repeated queries and improve readability.
CREATE VIEW salary_stats AS
SELECT
    department,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    AVG(salary) AS avg_salary
FROM users
GROUP BY department;

CREATE VIEW age_stats AS
SELECT
    department,
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    AVG(age) AS avg_age
FROM users
GROUP BY department;

CREATE VIEW dept_user_count AS
SELECT department, COUNT(*) AS num_users FROM users GROUP BY department;

-- Verification: Query the views.
SELECT * FROM salary_stats;
SELECT * FROM age_stats;
SELECT * FROM dept_user_count;

-- Step 7: Generate more data (1000 total)
-- Description: Add 900 more users to reach 1000.
-- Why: Tests performance with larger dataset.
CALL generate_users(900);

-- Verification: Check total count.
SELECT COUNT(*) AS total_users FROM users;
-- To view all generated data (caution: large output), use:
-- SELECT * FROM users ORDER BY id;

-- Step 8: Enable indexing
-- Description: Add indexes on age, department, salary for faster queries.
-- Why: Indexes speed up searches, sorts, and aggregations by reducing scan time.
CREATE INDEX idx_age ON users(age);
CREATE INDEX idx_department ON users(department);
CREATE INDEX idx_salary ON users(salary);

-- Verification: Check indexes.
SHOW INDEX FROM users;

-- Step 9: Enable full-text search
-- Description: Add full-text index on name for text searches.
-- Why: Allows efficient searching within text fields using MATCH AGAINST.
ALTER TABLE users ADD FULLTEXT idx_name_ft (name);

-- Verification: Check full-text index.
SHOW INDEX FROM users;

-- Step 10: Test full-text search
-- Description: Search for names containing 'User1' or similar.
-- Why: Demonstrates full-text capabilities for fuzzy or partial matches.
SELECT * FROM users WHERE MATCH(name) AGAINST('User1*' IN BOOLEAN MODE) LIMIT 10;

-- Verification: Should return matching rows.

-- Step 11: Test performance (conceptual)
-- Description: Run a query with EXPLAIN to show query plan.
-- Why: EXPLAIN shows if indexes are used, indicating performance improvement.
EXPLAIN SELECT department, AVG(salary) FROM users WHERE age > 30 GROUP BY department;

-- Verification: Look for 'Using index' in the plan, meaning indexes help.

-- Note: For actual speed testing, time queries manually (e.g., with BENCHMARK in MySQL).
-- Example: SELECT BENCHMARK(1000000, (SELECT COUNT(*) FROM users WHERE age > 30));

-- Step 12: Remove all generated data (optional cleanup)
-- Description: Delete all rows from the users table.
-- Why: To reset the table for re-testing or clean up.
-- TRUNCATE TABLE users;  -- Faster reset, clears data and resets auto-increment
-- Alternative: DELETE FROM users;
-- Verification: SELECT COUNT(*) FROM users;  -- Should be 0 after removal

-- Step 13: Clean up (optional)
-- Description: Drop database if needed.
-- Why: To reset for re-runs.
-- DROP DATABASE IF EXISTS advanced_test_db;

-- End of advanced SQL test.
-- This file covers data generation, aggregation, views, indexing, full-text search, and basic performance analysis.
