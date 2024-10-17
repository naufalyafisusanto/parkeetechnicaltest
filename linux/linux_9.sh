#!/bin/bash

# 9.  Membuat Script untuk Menambahkan SSH Key ke ‘authorized_keys’ (SSH)
#     Buatlah sebuah shell script yang menerima dua parameter: file key public dan
#     username. Script ini harus menambahkan public key ke file ‘~/.ssh/authorized_keys’ dari
#     user yang bersangkutan di server local.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <public_key_file> <username>"
  exit 1
fi

public_key_file=$1
username=$2

if [ ! -d "/home/$username/.ssh" ]; then
  mkdir -p "/home/$username/.ssh"
  chown "$username:$username" "/home/$username/.ssh"
fi

cat "$public_key_file" >> "/home/$username/.ssh/authorized_keys"

echo "Public key added to /home/$username/.ssh/authorized_keys"