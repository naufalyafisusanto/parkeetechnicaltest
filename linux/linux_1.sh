#!/bin/bash

# 1.  Pencarian File Berdasarkan Ekstensi file (MANAGEMENT FILE)
#     Buatlah sebuah shell script yang menerima dua parameter: direktori dan ekstensi file.
#     Script ini harus mencari semua file dengan ekstensi yang diberikan di dalam direktori
#     tersebut dan menampilkan daftar nama file yang ditemukan.

if [ $# -ne 2 ]; then
  echo "Usage: $0 <directory> <extension>"
  exit 1
fi

directory=$1

if [ ! -d "$directory" ]; then
  echo "Error: $directory is not a valid directory"
  exit 1
fi

extension=$2

find "$directory" -type f -name "*.$extension"