# Course Explorer v2

Proyek ini mendemonstrasikan implementasi State Management (Provider) dan Clean Architecture pada Flutter.

**Dikembangkan oleh:** 
Liam Arta Febrio (2415051087)

## Struktur Folder & Tanggung Jawab (Dependency Direction)

*   **`models/`**: Mendefinisikan struktur data (seperti `Course`). Hanya berisi cetakan objek murni tanpa logika aplikasi.
*   **`services/`**: Menangani komunikasi dengan sumber data eksternal (API atau JSON lokal). Bertugas mengambil raw data dan mem-parsing-nya menjadi Model.
*   **`repositories/`**: Lapisan abstraksi yang menjembatani *Service* dan *Provider*. Menyediakan sekumpulan fungsi baku agar *Provider* tidak perlu tahu detail implementasi pembacaan data.
*   **`providers/`**: Mengelola *application state* (data yang sedang aktif, status loading/error) dan menampung *business logic*. Memanggil data dari *Repository* dan menggunakan `notifyListeners()` untuk memperbarui UI.
*   **`screens/`**: Berisi halaman-halaman utama aplikasi (Home, Courses, Favorites, Profile). Bertugas membaca *state* dari *Provider* (via `context.watch`) dan merender kerangka halaman.
*   **`widgets/`**: Berisi potongan komponen antarmuka yang dapat digunakan ulang (*reusable*), seperti *Card* atau *Form*, untuk menjaga *Screen* tetap ringkas.

**Arah Dependensi Utama:**
Screen/Widget -> Provider -> Repository -> Service / Data Source

## Catatan Endpoint API (Worksheet 7)
*   **Base URL:** `https://course-api-pearl.vercel.app`
*   **Endpoint (List Courses):** `/courses`
*   **Method:** GET
*   **Status Code:** 200 OK
*   **Resource:** Course Data
*   **Struktur JSON:** Terdiri dari field `id`, `code`, `title`, `credits`, dan `status`.

# Course Data Manager

Aplikasi manajemen data mata kuliah berbasis Flutter dengan integrasi Backend-as-a-Service (BaaS) menggunakan Supabase.

## Deskripsi Aplikasi
Aplikasi ini memungkinkan pengguna untuk mengelola daftar mata kuliah melalui operasi CRUD (Create, Read, Update, Delete). Aplikasi dilengkapi dengan fitur *state management*, *loading state*, penanganan *error* (termasuk *network failure*), dan proteksi *Row Level Security* (RLS) di sisi *database*.

## Arsitektur & Teknologi
- **Frontend:** Flutter
- **Backend & Database:** Supabase (PostgreSQL)
- **State Management:** Provider
- **Design Pattern:** Clean Architecture (Repository Pattern & Dependency Injection)

## Cara Menjalankan Aplikasi
1. Pastikan Flutter SDK sudah terpasang.
2. Clone repositori ini.
3. Jalankan `flutter pub get` untuk mengunduh semua *dependencies*.
4. Konfigurasikan URL dan Anon Key Supabase pada file `lib/supabase_config.dart`.
5. Jalankan aplikasi menggunakan perintah `flutter run` atau melalui tombol Run/Debug di VS Code.