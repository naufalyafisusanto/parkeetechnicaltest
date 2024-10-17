#!/bin/bash

# 7.  Mengcopy public key ke server remote (SSH)
#     Buatlah sebuah shell script yang menerima tiga parameter: file public key, username,
#     dan ip address server. Script ini harus menyalin public key ke server remote untuk
#     memungkinkan user lain untuk melakukan ssh tanpa password.

if [ $# -ne 3 ]; then
  echo "Usage: $0 <public_key_file> <username> <server_ip>"
  exit 1
fi

public_key_file=$1
username=$2
server_ip=$3

ssh-copy-id -i "$public_key_file" "$username@$server_ip"

echo "Public key copied to $username@$server_ip"