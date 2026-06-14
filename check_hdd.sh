#!/bin/bash

# Mengambil persentase ruang penyimpanan yang sudah digunakan pada partisi '/'
# Contoh output 'df': 85% -> sed menghilangkan tanda '%' menjadi 85
USED_PERCENT=$(df / | grep / | awk '{print $5}' | sed 's/%//')

# Menghitung sisa kapasitas ruang penyimpanan yang masih tersedia (100% - terpakai)
FREE_PERCENT=$((100 - USED_PERCENT))

# Menampilkan report berupa notifikasi sisa space HDD ke layar terminal
echo "--------------------------------------------------"
echo "NOTIFIKASI: Space HDD anda tinggal $FREE_PERCENT%"
echo "--------------------------------------------------"

# Tambahan (Opsional): Memberikan peringatan kritis jika sisa ruang di bawah 15%
if [ "$FREE_PERCENT" -le 15 ]; then
    echo "PERINGATAN: Kapasitas penyimpanan Anda sangat kritis!"
fi
