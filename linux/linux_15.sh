#!/bin/bash

# 15. Monitoring Penggunaan Disk (MONITORING)
#     Buatlah sebuah shell script yang akan memonitor penggunaan disk pada sistem. Jika
#     penggunaan disk diatas 80%, script harus mengirimkan notifikasi melalui suatu service
#     lain (bebas menggunakan tools apapun untuk notifikasinya).

threshold=80

bot_token="API_TOKEN"
chat_id="CHAT_ID"
telegram_api_url="https://api.telegram.org/bot$bot_token/sendMessage"

send_telegram_message() {
  local message=$1
  curl -s -o /dev/null -X POST "$telegram_api_url" -d chat_id="$chat_id" -d text="$message"
}

while true; do
  combined_message=""

  while read output; do
    usep=$(echo $output | awk '{print $1}' | sed 's/%//g')
    mount_point=$(echo $output | awk '{print $2}')

    if [ $usep -ge $threshold ]; then
      if [ -z "$combined_message" ]; then
        combined_message="***WARNING DISK USAGE***\n"
        echo $combined_message
        current_date=$(date '+%Y-%m-%d %H:%M:%S')
        echo $current_date
        combined_message+="Reported on: $current_date\n"
      fi

      message="${usep}% at $mount_point"
      echo $message
      combined_message+="$message\n"
    fi
  done < <(df -h | awk 'NR>1 {print $5 " " $6}')

  if [ -n "$combined_message" ]; then
    combined_message=$(echo -e "$combined_message" | sed ':a;N;$!ba;s/\n/%0A/g')
    send_telegram_message "$combined_message"
  fi

  sleep 60
done