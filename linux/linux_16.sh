#!/bin/bash

# 16. Menampilan Informasi Sistem (MONITORING)
#     Buatlah sebuah shell script yang menampilkan informasi sistem dasar, termasuk nama
#     host, waktu sistem saat ini, dan jumlah pengguna yang sedang login.

echo "Hostname: $(hostname)"

echo "Current system time: $(date)"

echo "Number of users currently logged in: $(who | wc -l)"