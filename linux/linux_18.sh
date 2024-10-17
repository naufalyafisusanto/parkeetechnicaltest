#!/bin/bash

# 18. Konfigurasi Jaringan dengan ‘netplan’ (NETWORK)
#     Buatlah sebuah shell script yang mengkonfirmasi jaringan menggunakan ‘netplan’.
#     Script ini harus mengatur ip address pada interface network ‘eth0’ dengan detail berikut:
#       1. IP Address : 192.168.1.100’
#       2. Gateway: ‘192.168.1.1’
#       3. DNS: ‘8.8.8.8’ dan ‘8.8.4.4’

cat <<EOL | sudo tee /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOL

sudo netplan apply