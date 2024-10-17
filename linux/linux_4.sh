#!/bin/bash

# 4.  Backup Direktori dan Rotasi Log (MANAGEMENT FILE)
#     Buatlah sebuah shell script yang akan melakukan membackup sebuah direktori tertentu
#     dan menghapus backup yang lebih lama dari 7 hari. Script harus memiliki parameter
#     untuk menentukan direktori sumber dan direktori tujuan backup.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <source_directory> <backup_directory>"
  exit 1
fi

source_directory=$1
backup_directory=$2

if [ ! -d "$source_directory" ]; then
  echo "Error: $source_directory is not a valid directory"
  exit 1
fi

if [ ! -d "$backup_directory" ]; then
  echo "Backup directory does not exist, creating it..."
  mkdir -p "$backup_directory"
fi

backup_name="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

echo "Compressing directory: $source_directory"
tar -czvf "$backup_directory/$backup_name" -C "$source_directory" .
echo "Backup completed: $backup_directory/$backup_name"

if output=$(find "$backup_directory" -type f -name "*.tar.gz" -mtime +7 -exec rm -v {} \;); then
  if [ -n "$output" ]; then
    echo "$output"
    echo "Old backups older than 7 days have been deleted."
  fi
fi