#!/bin/bash

# 11. Pengelolaan Service (SERVICE)
#     Buatlah sebuah shell script yang dapat memulai, menghentikan, dan memeriksa status
#     dari sebuah service tertentu di sistem. Script harus memiliki parameter untuk
#     menentukan tindakan yang diinginkan (start, stop, status) dan nama service.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <start|stop|status> <service_name>"
  exit 1
fi

action=$1
service_name=$2

case $action in
  start)
    sudo systemctl start "$service_name"
    ;;
  stop)
    sudo systemctl stop "$service_name"
    ;;
  status)
    sudo systemctl status "$service_name"
    ;;
  *)
    echo "Invalid action. Use start, stop, or status."
    exit 1
    ;;
esac

if [ $? -eq 0 ]; then
  echo "Action $action performed on service $service_name"
fi