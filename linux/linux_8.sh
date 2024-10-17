#!/bin/bash

# 8.  Mengecheck Koneksi SSH ke Server Remote (SSH)
#     Buatlah sebuah shell script yang menerima dua parameter: username dan ip address
#     server. Script ini harus mencoba melakukan koneksi SSH ke server remote dan print
#     message yang menunjukan apakah koneksi berhasil atau gagal.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <username> <server_ip>"
  exit 1
fi

username=$1
server_ip=$2

ssh -o BatchMode=yes -o ConnectTimeout=5 "$username@$server_ip" exit

if [ $? -eq 0 ]; then
  echo "SSH connection to $username@$server_ip successful"
else
  echo "SSH connection to $username@$server_ip failed"
fi