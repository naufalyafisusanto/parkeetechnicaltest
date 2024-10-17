#!/bin/bash

# 17. Pengaturan Firewall dengan `sudo iptables` (NETWORK)
#     Buatlah sebuah shell script yang mengkonfigurasi aturan firewall menggunakan
#     ‘iptables’, ikuti persyaratan aturan dibawah ini:
#       1. Mengizinkan semua koneksi keluar.
#       2. Mengizinkan koneksi masuk ke port 22 (SSH), 80 (HTTP), dan 443 (HTTPS).
#       3. Menolak semua koneksi masuk lainnya.

sudo iptables -F

sudo iptables -P OUTPUT ACCEPT

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

sudo iptables -P INPUT DROP