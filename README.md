# 🌶️ Cabe Care - Aplikasi Perawatan Tanaman Cabe

Aplikasi iOS untuk membantu Anda merawat tanaman cabe dengan fitur pengingat penyiraman dan tips perawatan.

## 📱 Fitur Utama

### 1. Jadwal Penyiraman 💧
- **Tambah Jadwal**: Buat jadwal penyiraman untuk setiap tanaman cabe Anda
- **Notifikasi Otomatis**: Dapatkan pengingat otomatis saat waktu penyiraman tiba
- **Interval Fleksibel**:
  - Setiap Hari
  - 2x Sehari
  - 2 Hari Sekali
  - 3 Hari Sekali
  - Seminggu Sekali
- **Kelola Jadwal**: Edit, hapus, atau nonaktifkan jadwal kapan saja
- **Catatan**: Tambahkan catatan khusus untuk setiap jadwal

### 2. Tips Perawatan 💡
- **Koleksi Tips**: 10+ tips lengkap tentang perawatan tanaman cabe
- **Pencarian Tips**: Cari tips berdasarkan kata kunci (penyiraman, pemupukan, dll)
- **Cari di Internet**: Fitur untuk mencari tips tambahan
- **Notifikasi Tips**: Dapatkan notifikasi saat menemukan tips baru
- **Detail Tips**: Lihat penjelasan lengkap setiap tips
- **Bagikan**: Bagikan tips berguna ke teman Anda

## 🛠 Teknologi

- **Platform**: iOS 14.0+
- **Framework**: UIKit (programmatic UI, tanpa Storyboard)
- **Language**: Swift 5
- **Architecture**: MVC (Model-View-Controller)
- **Data Persistence**: UserDefaults
- **Notifications**: UserNotifications framework

## 📋 Struktur Proyek

```
cabe-ios/
├── AppDelegate.swift              # App lifecycle
├── SceneDelegate.swift            # Scene lifecycle
├── Info.plist                     # App configuration
│
├── Models/
│   ├── WateringSchedule.swift    # Model untuk jadwal penyiraman
│   └── PlantTip.swift             # Model untuk tips perawatan
│
├── Managers/
│   ├── NotificationManager.swift # Mengelola notifikasi lokal
│   ├── TipsSearchManager.swift   # Mencari dan mengelola tips
│   └── DataManager.swift          # Persistence data
│
├── ViewControllers/
│   ├── MainViewController.swift           # Tab bar controller
│   ├── ScheduleViewController.swift       # Daftar jadwal
│   ├── AddScheduleViewController.swift    # Tambah/edit jadwal
│   ├── TipsViewController.swift           # Browse tips
│   └── TipDetailViewController.swift      # Detail tips
│
└── Views/
    ├── ScheduleCell.swift         # Custom cell untuk jadwal
    └── TipCell.swift              # Custom cell untuk tips
```

## 🚀 Cara Menggunakan

### Setup Proyek

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd cabe-ios
   ```

2. **Buka dengan Xcode**
   - Buka Xcode
   - File → Open → Pilih folder `cabe-ios`
   - Atau buat project baru dan copy semua file ke project

3. **Build dan Run**
   - Pilih simulator atau device
   - Tekan Cmd+R atau klik tombol Play

### Menggunakan Aplikasi

#### Menambah Jadwal Penyiraman:
1. Buka tab **"Jadwal"**
2. Tap tombol **"+"** di kanan atas
3. Isi detail jadwal:
   - Nama tanaman
   - Waktu penyiraman
   - Interval penyiraman
   - Catatan (opsional)
4. Tap **"Save"**

#### Mengelola Jadwal:
- **Edit**: Tap pada jadwal untuk mengedit
- **Hapus**: Swipe ke kiri dan tap "Hapus"
- **Aktif/Nonaktif**: Toggle switch di sebelah kanan

#### Mencari Tips:
1. Buka tab **"Tips"**
2. Gunakan search bar untuk mencari tips lokal
3. Atau tap **"Cari Tips di Internet"** untuk mencari tips baru
4. Tap pada tips untuk melihat detail lengkap
5. Tap **"Bagikan Tips"** untuk share ke teman

## 📝 Tips Perawatan yang Tersedia

Aplikasi ini dilengkapi dengan 10 tips perawatan cabe:

1. **Penyiraman Rutin** - Jadwal dan teknik penyiraman
2. **Sinar Matahari** - Kebutuhan cahaya optimal
3. **Pemupukan** - Jenis dan jadwal pemupukan
4. **Drainase yang Baik** - Media tanam yang tepat
5. **Pemangkasan Cabang** - Teknik pemangkasan
6. **Pengendalian Hama** - Cara mengatasi hama
7. **Suhu Ideal** - Kondisi suhu optimal
8. **Penyerbukan** - Membantu proses penyerbukan
9. **Kelembaban Udara** - Manajemen kelembaban
10. **Pemanenan** - Waktu dan cara panen yang tepat

## 🔔 Notifikasi

Aplikasi akan mengirim notifikasi untuk:

- **Pengingat Penyiraman**: Sesuai jadwal yang Anda buat
- **Tips Baru**: Saat menemukan tips dari pencarian internet

**Catatan**: Pastikan Anda mengizinkan notifikasi saat pertama kali membuka aplikasi.

## 🎨 Fitur UI

- **Tab Bar Navigation**: Navigasi mudah antara Jadwal dan Tips
- **Dark Mode Support**: Otomatis menyesuaikan dengan sistem
- **Search Bar**: Pencarian cepat untuk tips
- **Swipe Actions**: Gestur intuitif untuk menghapus jadwal
- **Empty State**: Panduan saat belum ada data
- **Loading States**: Indikator saat memuat data

## 🔧 Pengembangan Lebih Lanjut

Beberapa ide untuk pengembangan:

- [ ] Integrasi dengan API cuaca untuk rekomendasi penyiraman
- [ ] Galeri foto untuk tracking pertumbuhan tanaman
- [ ] Widget untuk quick access ke jadwal
- [ ] iCloud sync untuk backup data
- [ ] Apple Watch companion app
- [ ] Statistik penyiraman
- [ ] Reminder berbasis lokasi
- [ ] Integrasi dengan kalender

## 📄 Lisensi

Project ini dibuat untuk keperluan pembelajaran dan pengembangan aplikasi iOS.

## 👨‍💻 Pengembang

Dibuat dengan ❤️ menggunakan Swift dan UIKit

---

**Selamat Berkebun! 🌶️🌱**
