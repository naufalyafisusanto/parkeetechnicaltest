#!/bin/bash

# 3.  Menghitung dan Menampilkan Statistik File (MANAGEMENT FILE)
#     Buatlah sebuah shell script yang akan menghitung dan menampilkan jumlah baris, kata
#     dan karakter dari semua file teks dalam sebuah direktori tertentu. Hasilnya harus
#     ditampilkan dalam format table.

if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

directory=$1

if [ ! -d "$directory" ]; then
  echo "Error: $directory is not a valid directory"
  exit 1
fi

printf "%-8s %-8s %-13s %-50s\n" "Lines" "Words" "Characters" "File Name"
printf "%-8s %-8s %-13s %-50s\n" "-----" "-----" "----------" "---------"

find "$directory" -type f | while read file; do
  if [ -f "$file" ]; then
    file_type=$(file --mime-type -b "$file")
  
    if [[ "$file_type" == text/* ]]; then
      relative_path=$(realpath --relative-to="$directory" "$file")
      
      lines=$(wc -l < "$file")
      words=$(wc -w < "$file")
      chars=$(wc -m < "$file")

      if [ "$(tail -c 1 "$file")" != "" ]; then
          lines=$((lines + 1))
      fi

      printf "%-8s %-8s %-13s %-50s\n" "$lines" "$words" "$chars" "$relative_path"
    fi
  fi
done