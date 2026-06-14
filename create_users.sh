#!/bin/bash

# Pastikan skrip dijalankan sebagai root/sudo
if [ "$EUID" -ne 0 ]; then
  echo "Error: Silakan jalankan skrip ini dengan sudo!"
  exit 1
fi

FILE="userlist.txt"

# Cek apakah file daftar user ada
if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE tidak ditemukan!"
    exit 1
fi

echo "=== Memulai Pembuatan User Baru ==="

# Membaca baris demi baris dari file userlist.txt
while IFS= read -r username || [ -n "$username" ]; do
    # Menghilangkan spasi jika ada
    username=$(echo "$username" | tr -d '[:space:]')
    
    # Lewati jika baris kosong
    if [ -z "$username" ]; then
        continue
    fi

    # Cek apakah user sudah ada di sistem
    if id "$username" &>/dev/null; then
        echo "Info: User '$username' sudah terdaftar di sistem. Dilewati."
    else
        # Membuat user baru
        useradd -m -s /bin/bash "$username"
        
        # Membuat password dengan pola: namauser@123
        PASSWORD="$username@123"
        
        # Menerapkan password ke user menggunakan chpasswd
        echo "$username:$PASSWORD" | chpasswd
        
        echo "Sukses: User '$username' berhasil dibuat dengan password '$PASSWORD'."
    fi
done < "$FILE"

echo "=== Proses Pembuatan User Selesai ==="
