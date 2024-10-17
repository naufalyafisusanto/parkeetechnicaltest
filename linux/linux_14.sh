#!/bin/bash

# 14. Memonitoring Penggunaan CPU (MONITORING)
#     Buatlah sebuah shell script yang akan memonitor penggunaan CPU pada sistem. Jika
#     penggunaan CPU rata-rata dalam 1 menit diatas 75%, script harus mencatat informasi
#     tersebut ke dalam sebuah log file.

log_file="/var/log/cpu_usage.log"

if [ ! -f "$log_file" ]; then
  sudo touch "$log_file"
fi

while true; do
  load_avg=$(uptime | awk -F'[a-z]:' '{ print $2 }' | awk '{ print $1 }' | tr -d ',')

  if [[ "$load_avg" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    cpu_usage=$(echo "$load_avg * 100" | bc)

    if (( $(echo "$cpu_usage > 75" | bc -l) )); then
      echo "$(date): CPU usage is high! Load average (1 minute) is $load_avg ($cpu_usage%)" | sudo tee -a "$log_file"
    else
      echo "$(date): CPU usage is $load_avg"
    fi
  else
    echo "Error: Invalid load average format: $load_avg"
  fi

  sleep 60
done