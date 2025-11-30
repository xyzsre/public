#!/bin/bash

# MariaDB Backup Compression Test Script
# This script installs compression tools and compresses a backup file using different methods.
# Assumes backup_test_db.sql exists from previous backup test.
# Run with: ./mariadb_backup_compression_test.sh

echo "=== MariaDB Backup Compression Test ==="
echo ""

# Step 1: Install compression tools
echo "1. Installing compression tools (zip, tar, gzip, bzip2, xz-utils)..."
sudo apt update
sudo apt install -y zip tar gzip bzip2 xz-utils
echo "   Description: Installs tools for various compression formats."
echo ""

# Check if backup file exists
if [ ! -f "backup_test_db.sql" ]; then
    echo "Error: backup_test_db.sql not found. Run the backup test script first."
    exit 1
fi

echo "Backup file found: backup_test_db.sql"
echo ""

# Step 2: Compress with gzip
echo "2. Compressing with gzip..."
cp backup_test_db.sql backup_test_db.sql.gz.base
gzip backup_test_db.sql.gz.base
mv backup_test_db.sql.gz.base.gz backup_test_db.sql.gz
ls -lh backup_test_db.sql.gz
echo "   Description: gzip creates .gz files; fast compression, good for speed."
echo ""

# Step 3: Compress with bzip2
echo "3. Compressing with bzip2..."
cp backup_test_db.sql backup_test_db.sql.bz2.base
bzip2 backup_test_db.sql.bz2.base
mv backup_test_db.sql.bz2.base.bz2 backup_test_db.sql.bz2
ls -lh backup_test_db.sql.bz2
echo "   Description: bzip2 creates .bz2 files; better compression than gzip, slower."
echo ""

# Step 4: Compress with xz
echo "4. Compressing with xz..."
cp backup_test_db.sql backup_test_db.sql.xz.base
xz backup_test_db.sql.xz.base
mv backup_test_db.sql.xz.base.xz backup_test_db.sql.xz
ls -lh backup_test_db.sql.xz
echo "   Description: xz creates .xz files; high compression ratio, slower than bzip2."
echo ""

# Step 5: Compress with zip
echo "5. Compressing with zip..."
zip backup_test_db.sql.zip backup_test_db.sql
ls -lh backup_test_db.sql.zip
echo "   Description: zip creates .zip archives; supports multiple files, cross-platform."
echo ""

# Step 6: Compress with tar + gzip
echo "6. Compressing with tar + gzip..."
tar -czf backup_test_db.tar.gz backup_test_db.sql
ls -lh backup_test_db.tar.gz
echo "   Description: tar bundles files, gzip compresses; standard for archives."
echo ""

# Step 7: Compare file sizes
echo "7. Comparing compressed file sizes..."
echo "Original file:"
ls -lh backup_test_db.sql
echo ""
echo "Compressed files:"
ls -lh backup_test_db.sql.gz backup_test_db.sql.bz2 backup_test_db.sql.xz backup_test_db.sql.zip backup_test_db.tar.gz
echo "   Description: Shows size differences; smaller files mean better compression."
echo ""

# Cleanup: Remove compressed files (optional)
echo "Cleanup: Removing compressed files (uncomment to keep)..."
# rm backup_test_db.sql.gz backup_test_db.sql.bz2 backup_test_db.sql.xz backup_test_db.sql.zip backup_test_db.tar.gz
echo "   Compressed files removed (commented out)."
echo ""

echo "=== Compression Test Completed ==="
echo "All compression methods tested!"

