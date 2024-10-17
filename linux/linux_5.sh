#!/bin/bash

# 5.  Automasi Pembaharuan Sistem (BASIC SYSTEM)
#     Buatlah sebuah shell script yang akan secara otomatis memperbaharui semua package
#     di sistem menggunakan package manager yang sesuai dengan family linux (misal ‘apt’,
#     ‘yum’ atau sebagainya). Script harus juga mencatat hasil dari setiap pembaruan
#     kedalam sebuah file log.

log_file="/var/log/system_update_$(date +%Y%m%d_%H%M%S).log"

if command -v apt >/dev/null 2>&1; then
  sudo apt update 2>/dev/null | tee -a "$log_file"
  sudo apt upgrade -y 2>/dev/null | tee -a "$log_file"
elif command -v yum >/dev/null 2>&1; then
  sudo yum update -y 2>/dev/null | tee -a "$log_file"
else
  echo "Unsupported package manager." | tee -a "$log_file"
  exit 1
fi

echo "System update completed. Log saved to $log_file"