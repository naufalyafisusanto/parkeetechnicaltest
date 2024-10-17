#!/bin/bash

# 13. Membuat Unit File Systemd untuk Service Sederhana (SERVICE)
#     Buatlah sebuah shell script yang membuat sebuah file systemd untuk menjalankan script
#     python sederhana. File ini harus ditempatkan di folder `/etc/systemd/system/`. Script
#     python harus dijalankan sebagai service yang dapat dijalankan, dihentikan dan di cek
#     status service tersebut menggunakan systemctl.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <service_name> <path_to_python_script>"
  exit 1
fi

service_name=$1
relative_path=$2
systemd_file="/etc/systemd/system/$service_name.service"

if command -v realpath >/dev/null 2>&1; then
  python_script=$(realpath "$relative_path")
elif command -v readlink >/dev/null 2>&1; then
  python_script=$(readlink -f "$relative_path")
else
  echo "Error: Neither 'realpath' nor 'readlink' are available to resolve absolute path."
  exit 1
fi

if [ ! -f "$python_script" ]; then
  echo "Error: Python script not found at $python_script"
  exit 1
fi

sudo bash -c "cat > $systemd_file" <<EOL
[Unit]
Description=$service_name Python Service

[Service]
ExecStart=/usr/bin/python3 $python_script
Restart=on-failure
User=root
WorkingDirectory=$(dirname "$python_script")

[Install]
WantedBy=multi-user.target
EOL

sudo chmod 644 "$systemd_file"

sudo systemctl daemon-reload

echo "Systemd service file created at $systemd_file"
echo "You can now start the service with: sudo systemctl start $service_name"