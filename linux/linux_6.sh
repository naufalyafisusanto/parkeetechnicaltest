#!/bin/bash

# 6.  Membuat dan Menyimpan SSH Key (SSH)
#     Buatlah sebuah shell script yang akan membuat sepasang SSH Key (public dan private)
#     dengan menggunakan ssh-keygen dan menyimpannya di direktori yang ditentukan oleh
#     pengguna sebagai parameter. Jika direktori tidak ada, script harus membuatnya terlebih
#     dahulu.

if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

directory=$1

if [ ! -d "$directory" ]; then
  echo "Directory does not exist. Creating it..."
  mkdir -p "$directory"
fi

ssh-keygen -t rsa -b 4096 -f "$directory/id_rsa" -N ""

echo "SSH key pair created and saved in $directory"