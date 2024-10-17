#!/bin/bash

# 10. Menghapus SSH Key dari ‘authorized_keys’ (SSH)
#     Buatlah sebuah shell script yang menerima dua parameter: string yang unique dari key
#     public dan username. Script ini harus menghapus public key yang mengandung string
#     unique tersebut dari file ‘~/.ssh/authorized_keys’ dari user yang bersangkutan.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <unique_string_in_key> <username>"
  exit 1
fi

unique_string=$1
username=$2
authorized_keys_file="/home/$username/.ssh/authorized_keys"

if [ ! -f "$authorized_keys_file" ]; then
  echo "Error: $authorized_keys_file does not exist."
  exit 1
fi

if grep -q "$unique_string" "$authorized_keys_file"; then
  sed -i "/$unique_string/d" "$authorized_keys_file"
  
  if grep -q "$unique_string" "$authorized_keys_file"; then
    echo "Failed to remove the SSH key containing $unique_string."
  else
    echo "SSH key containing $unique_string successfully removed from $authorized_keys_file."
  fi
else
  echo "No SSH key containing $unique_string found in $authorized_keys_file."
fi