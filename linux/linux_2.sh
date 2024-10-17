#!/bin/bash

# 2.  Backup dan Kompresi File (MANAGEMENT FILE)
#     Buatlah sebuah shell script yang akan mem-backup sebuah direktori tertentu dan
#     mengompres hasil backup tersebut dengan format .tar.gz. Script harus memiliki
#     parameter input untuk menentukan direktori sumber dan lokasi penyimpanan hasil
#     backup.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <source_directory> <destination_backup>"
  exit 1
fi

source_directory=$1

if [ ! -d "$source_directory" ]; then
  echo "Error: $source_directory is not a valid directory"
  exit 1
fi

destination_backup=$2
backup_name="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

tar -czvf "$destination_backup/$backup_name" -C "$source_directory" .
echo "Backup saved to $destination_backup/$backup_name"