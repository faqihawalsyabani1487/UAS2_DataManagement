1. userlist.txt (Daftar Pengguna Baru)
   File ini merupakan file input teks sederhana yang berisi daftar nama pengguna yang ingin Anda buat di dalam sistem.
   - Isi File: ```text
      budi
      andi
      citra
   - Penjelasan: Setiap baris mewakili satu username. File ini dibaca oleh skrip create_users.sh untuk membuat akun pengguna secara massal dan otomatis tanpa perlu mengetikkan perintah useradd satu per satu.

2. create_users.sh (Skrip Otomatisasi Pembuatan User)
   Ini adalah skrip Bash (Shell Script) yang berfungsi sebagai mesin pemroses untuk membaca userlist.txt dan mengotomatiskan pembuatan akun.
   - Cara Kerja:
     - Skrip pertama-tama memastikan bahwa ia dijalankan dengan hak akses Administrator (root/sudo).
     - Skrip membaca file userlist.txt baris demi baris.
     - Jika pengguna belum ada di sistem, skrip akan membuat pengguna baru tersebut lengkap dengan direktori rumahnya (/home/username).
     - Skrip secara otomatis membuat kata sandi dengan pola namauser@123 (misalnya: budi@123, andi@123, citra@123) lalu menerapkannya menggunakan perintah chpasswd.

3. catatan.txt (Data Contoh di Dalam Disk Baru)
   File ini adalah file teks tiruan yang Anda buat untuk menyimulasikan data penting di dalam penyimpanan baru berkapasitas 50MB yang telah di-mounting (di /mnt/data_baru).
   Isi File:
   - Plaintext
   - Data transaksi penting perusahaan
   - Penjelasan: File ini diletakkan di dalam disk baru sebelum proses backup otomatis dijalankan. Keberadaan file ini berfungsi sebagai pembuktian bahwa proses cadangan (backup) benar-benar menyalin data yang ada di dalam direktori penyimpanan tersebut.

4. backup_simulasi.tar.gz (File Hasil Backup Otomatis)
   Ini adalah file arsip terkompresi (.tar.gz) yang dihasilkan dari simulasi perintah backup otomatis (yang dijadwalkan lewat cron job).
   - Uraian Isi Hasil Backup (Saat Diekstrak/Dilihat):
     Arsip ini mengunci dan mengamankan seluruh isi dari direktori /mnt/data_baru. Berdasarkan struktur metadata di dalamnya, file ini mengarsip:
     - ./ (Direktori utama penyimpanan)
     - ./dokumen1.txt (File dokumen kosong)
     - ./catatan.txt (File yang berisi teks "Data transaksi penting perusahaan")
     - ./lost+found/ (Sistem direktori bawaan Linux ext4 untuk pemulihan data)
   - Penjelasan: Opsi -C /mnt/data_baru . yang digunakan pada perintah tar berhasil membuat struktur file backup menjadi bersih, sehingga saat file diuraikan kembali, file langsung berada di root arsip tanpa membawa-bawa folder induk /mnt/data_baru/.

5. check_hdd.sh (Skrip Pemeriksa Sisa Ruang Harddisk)
   Ini adalah skrip Bash mandiri yang berfungsi untuk memantau kapasitas penyimpanan pada partisi utama (/) sistem Anda.
   - Cara Kerja:
     - Skrip menggunakan perintah df / untuk mengambil baris data utilitas penyimpanan lokal.
     - Skrip memfilter teks menggunakan awk dan sed untuk mengambil angka persentase penyimpanan yang sudah digunakan (USED_PERCENT), lalu menghilangkan simbol %.
     - Skrip melakukan operasi matematika sederhana: FREE_PERCENT = 100 - USED_PERCENT untuk mencari sisa kapasitas yang masih kosong.
     - Output yang Ditampilkan: Skrip mencetak laporan notifikasi ke layar terminal dengan format:

Plaintext

--------------------------------------------------
NOTIFIKASI: Space HDD anda tinggal [X]%
--------------------------------------------------

  - Skrip ini juga memiliki logika pengaman tambahan yang akan memunculkan teks "PERINGATAN: Kapasitas penyimpanan Anda sangat kritis!" jika sisa ruang penyimpanan di komputer Anda terdeteksi berada di bawah atau sama dengan 15%.
