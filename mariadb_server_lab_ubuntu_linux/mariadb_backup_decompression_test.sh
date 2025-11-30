#!/bin/bash

# MariaDB Backup Decompression Test Script
# This script decompresses previously compressed backup files.
# Assumes compressed files from compression test exist.
# Run with: ./mariadb_backup_decompression_test.sh

echo "=== MariaDB Backup Decompression Test ==="
echo ""

# Function to check and decompress
decompress_if_exists() {
    local file=$1
    local cmd=$2
    local desc=$3
    if [ -f "$file" ]; then
        echo "Decompressing $file..."
        eval "$cmd"
        echo "   Description: $desc"
        echo ""
    else
        echo "$file not found, skipping."
        echo ""
    fi
}

# Step 1: Decompress gzip file
decompress_if_exists "backup_test_db.sql.gz" "gzip -d backup_test_db.sql.gz" "gzip decompresses .gz files; recreates original file."

# Step 2: Decompress bzip2 file
decompress_if_exists "backup_test_db.sql.bz2" "bzip2 -d backup_test_db.sql.bz2" "bzip2 decompresses .bz2 files; recreates original file."

# Step 3: Decompress xz file
decompress_if_exists "backup_test_db.sql.xz" "xz -d backup_test_db.sql.xz" "xz decompresses .xz files; recreates original file."

# Step 4: Decompress zip file
decompress_if_exists "backup_test_db.sql.zip" "unzip backup_test_db.sql.zip" "unzip extracts .zip archives; recreates original file."

# Step 5: Decompress tar.gz file
decompress_if_exists "backup_test_db.tar.gz" "tar -xzf backup_test_db.tar.gz" "tar extracts .tar.gz archives; recreates original file."

# Step 6: Verify decompressed files
echo "6. Verifying decompressed files..."
if [ -f "backup_test_db.sql" ]; then
    echo "Original file restored: backup_test_db.sql"
    ls -lh backup_test_db.sql
else
    echo "Warning: Original file not found after decompression."
fi
echo "   Description: Checks if the original backup file is restored."
echo ""

# Cleanup: Remove compressed files
echo "Cleanup: Removing compressed files..."
rm -f backup_test_db.sql.gz backup_test_db.sql.bz2 backup_test_db.sql.xz backup_test_db.sql.zip backup_test_db.tar.gz
echo "   Description: Cleans up compressed files after decompression."
echo ""

echo "=== Decompression Test Completed ==="
echo "All available compressed files decompressed!"
