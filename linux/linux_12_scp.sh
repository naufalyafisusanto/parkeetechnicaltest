#!/bin/bash

# 12. Men-copy Direktori ke Server Remote (SCP)
#     Buatlah sebuah 2 shell script (scp, dan rsync) yang menerima tiga parameter: file
#     source, username, dan ip address server tujuan. Script ini harus menyalin file tersebut
#     ke direktori home pengguna di server remote menggunakan ‘scp’ dan ‘rsync’

if [ $# -ne 3 ]; then
  echo "Usage: $0 <source_directory> <username> <server_ip>"
  exit 1
fi

source_directory=$1
username=$2
server_ip=$3

scp -r "$source_directory" "$username@$server_ip:~/"

if [ $? -eq 0 ]; then
  echo "Directory $source_directory copied to $username@$server_ip successfully using SCP."
else
  echo "Failed to copy directory $source_directory to $username@$server_ip using SCP."
fi