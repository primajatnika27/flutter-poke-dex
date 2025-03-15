# Pokédex App

Aplikasi Pokédex mobile yang dibangun dengan Flutter, menggunakan Clean Architecture dan GetX untuk state management.

## Fitur

- Daftar Pokémon dengan infinite scrolling
- Detail Pokémon yang menampilkan:
  - Informasi dasar (nama, tipe, gambar)
  - Statistik dasar (HP, Attack, Defense, dll)
  - Evolusi
  - Daftar gerakan (moves)
- UI yang responsif dan menarik
- Pencarian Pokémon

## Teknologi & Arsitektur

### Teknologi
- Flutter
- GetX untuk state management
- Dio untuk HTTP requests
- Get_It untuk dependency injection
- Dartz untuk functional programming (Either type)
- Equatable untuk perbandingan objek

### Arsitektur
Project ini menggunakan Clean Architecture dengan struktur sebagai berikut:

```
lib/
├── common/          # Komponen UI yang umum digunakan
├── config/          # Konfigurasi aplikasi
├── core/            # Core utilities dan error handling
├── features/        # Fitur-fitur aplikasi
│   └── pokemon/     # Fitur Pokémon
│       ├── data/            # Layer data
│       │   ├── datasources/ # Sumber data (API, local)
│       │   ├── models/      # Model data
│       │   └── repositories/ # Implementasi repository
│       ├── domain/          # Business logic
│       │   ├── entities/    # Entitas domain
│       │   ├── repositories/ # Interface repository
│       │   └── usecases/    # Use cases
│       └── presentation/    # UI
│           ├── controllers/ # GetX controllers
│           ├── pages/       # Halaman UI
│           └── widgets/     # Komponen UI
├── di.dart          # Dependency injection setup
└── main.dart        # Entry point aplikasi
```

## Cara Menjalankan

### Prasyarat
- Flutter SDK (versi 3.1.3 atau lebih baru)
- Dart SDK (versi yang kompatibel dengan Flutter)
- Android Studio / VS Code dengan plugin Flutter

### Langkah-langkah
1. Clone repository
   ```
   git clone <repository-url>
   ```

2. Masuk ke direktori project
   ```
   cd poke_dex
   ```

3. Install dependencies
   ```
   flutter pub get
   ```

4. Jalankan aplikasi
   ```
   flutter run
   ```

## Unit Testing

Project ini dilengkapi dengan unit test untuk memastikan kualitas kode. Test dibagi menjadi beberapa kategori:

- **Unit Tests**: Menguji komponen individual seperti use cases dan controllers
- **Widget Tests**: Menguji komponen UI

### Menjalankan Test

Untuk menjalankan semua test:
```
flutter test
```

Untuk menjalankan test tertentu:
```
flutter test test/features/pokemon/presentation/controllers/pokemon_detail_controller_test.dart
```

### Struktur Test

```
test/
├── features/
│   └── pokemon/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── controllers/
│           ├── pages/
│           └── widgets/
└── test_helpers/
    └── test_di.dart  # Helper untuk dependency injection dalam testing
```
## Screenshoot
![WhatsApp Image 2025-03-15 at 8 16 40 PM](https://github.com/user-attachments/assets/a7a8e113-bf78-43da-bb8f-f6225f9058ff)
![WhatsApp Image 2025-03-15 at 8 16 40 PM (1)](https://github.com/user-attachments/assets/1ae85f04-2964-477e-bcac-377d9855ba18)
![WhatsApp Image 2025-03-15 at 8 16 41 PM](https://github.com/user-attachments/assets/04af5d22-bb4b-4354-a7cd-b63b02ac2a33)
![WhatsApp Image 2025-03-15 at 8 16 41 PM (1)](https://github.com/user-attachments/assets/83800a9f-63e6-460d-95e2-bd8b090eecfa)
![WhatsApp Image 2025-03-15 at 8 16 41 PM (2)](https://github.com/user-attachments/assets/3b154b83-d0f6-46fa-a856-a6ac4de282c9)
![WhatsApp Image 2025-03-15 at 8 16 42 PM](https://github.com/user-attachments/assets/7c164a11-f588-4e6f-80c2-95f04474aa11)
![WhatsApp Image 2025-03-15 at 8 16 42 PM (1)](https://github.com/user-attachments/assets/e60546db-ef16-4edc-b1a3-88d31400f1ea)
![WhatsApp Image 2025-03-15 at 8 16 42 PM (2)](https://github.com/user-attachments/assets/66c42f67-140b-419d-a235-c9872616105c)

