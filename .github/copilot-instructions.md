# Flutter Development Guidelines

U can find our reuseable widget at 
lib/core/components/ in /atom, /molecule, /organism

## Design Principles
1. Always create unique, elegant, premium UIs
2. Avoid animations entirely
3. Do not use SliverWidgets
4. Add multiple sections to pages when appropriate
5. Never use ListTile widgets
6. Don't implement BottomNavigationBar (TabBar is acceptable if you provide content for each tab)
7. In newer Flutter versions, use `.withAlpha(value)` instead of `.withOpacity(value)`
8. Prevent UI overflow and ensure comfortable display on mobile screens

## Core Components
- Use components from `lib/core/components`: textfield, space, button, form widgets
- Implement ReuseKit framework components throughout the project
- Follow the established theme configuration

<!-- ## Form Handling
- **TextFields**: 
    - Use `onChanged` event to capture values
    - Set initial values with the `value:` property
    - Do NOT use TextEditingController anywhere
- **Buttons**:
    - Always use solid QButton variants
    - Avoid outlined button styles -->

## Styling & Layout
- Use `.withAlpha(value)` instead of `.withOpacity(value)`
- Prefer the `spacing` property in Column/Row over multiple SizedBox widgets
- Create visually balanced layouts with appropriate padding and margins
- Use consistent spacing throughout the application

## Loading States
- Handle page loading manually with a boolean state variable and CircularProgressIndicator
- Only use EasyLoading.show/dismiss when a button click requires loading
- Never use EasyLoading.show/dismiss for entire page loading, for example when getting data from API at the beginning of the page, please use bool loading state and CircularProgressIndicator instead

## Code Architecture
lib  
├── app/app.dart ( all import for app folder)
├── core/core.dart ( all import for core folder)
│   ├── components
│   ├── data
│   ├── exceptions
│   ├── extensions
│   ├── failures
│   ├── helpers
│   ├── networks
│   ├── pages
│   ├── preferences
│   ├── usecases
│   ├── utils
├── features
│   ├── auth/auth.dart( all import for auth folder)
│   │   ├── data/data.dart (all import for auth data folder)
│   │   │   ├── models/models.dart (all import for auth models folder)
│   │   │   ├── repositories/repositories.dart (all import for auth repositories folder)
│   │   │   ├── sources/sources.dart (all import for auth sources folder)
│   │   ├── domain/domain.dart (all import for auth domain folder)
│   │   │   ├── entities/entities.dart (all import for auth entities folder)
│   │   │   ├── repositories/repositories.dart (all import for auth repositories folder)
│   │   │   └── usecases/usecases.dart  (all import for auth usecases folder)
│   │   └── presentation/presentation.dart (all import for auth presentation folder)
│   │       ├── blocs/blocs.dart (all import for auth blocs folder)
│   │       ├── components/components.dart (all import for auth components folder)
│   │       ├── pages/pages.dart (all import for auth pages folder)
│   ├── home/home.dart  ( all import for home folder)
│   │   ├── data/data.dart (all import for home data folder)
│   │   │   ├── models/models.dart (all import for home models folder)
│   │   │   ├── repositories/repositories.dart (all import for home repositories folder)
│   │   │   ├── sources/sources.dart (all import for home sources folder)
│   │   ├── domain/domain.dart (all import for home domain folder)
│   │   │   ├── entities/entities.dart (all import for home entities folder)
│   │   │   ├── repositories/repositories.dart (all import for home repositories folder)
│   │   │   └── usecases/usecases.dart (all import for home usecases folder)
│   │   └── presentation/presentation.dart (all import for home presentation folder)
│   │       ├── blocs/blocs.dart (all import for home blocs folder)
│   │       ├── components/components.dart (all import for home components folder)
│   │       ├── pages/pages.dart (all import for home pages folder)
│   └── ... (other features)
├── main_prod.dart
├── main_dev.dart

## Naming
- Follow view naming convention: `features/auth/presentation/pages/xxx/page.dart` (e.g., login, register)
- Use the same page for relation feature (e.g., login, register, forgot password) 
- Use `part of` or `part` directives in presentation pages/section to root features
- page do not need explicit imports as everything is available in core.dart

## IMport
jika ada service atau model, itu tidak perlu du import lagi,
karena sudah ada di core.dart

<!-- ## Validation
validation menggunakan class Valdiator, dan di impplementasikan dengan formKey,
Jadi tidak perlu diberi IF IF IF lagi
lib\core\util\validator\validator.dart -->


<!-- ## Reuseable Widget
semua widget yang di awali Q, misalnya QTextField, QButton, QCard, dll adalah widget yang reusable yang sudah saya buat,
dan cukup mengimport core.dart saja, dokumentasi pengunaannya ada di:
.github/widget-docs.md

Jika menggunakan reuseable widget,
Jangan gunakan argument yang tidak ada di dokumentasi,

Untuk mengatur initialValue, gunakan property value:
Contoh:
Q...(
  ...
  value: _email,
 ...
)

* Semua reuseable widget untuk form wajib di isi event
onChanged, tidak boleh di null kan. -->


### Aturan untuk Reuseable Widget yang saya buat:
* Tidak perlu mendefinisikan maxLength atau maxLines.
* Tidak perlu mendefinisikan keyboardType:
* Tidak perlu mengatur suffixIcon
* Kalau pakai colorset seperti primaryColor, mestinya widget-nya tidak di definsiikan dengan const
* Jangan mengatur height dari QButton
* Jangan gunakan property selain yang saya contohkan di dokumentasi reuseable widget


### REQUIRED
Setiap membuat halaman baru wajib mengimport kedua hal ini:  
import 'package:flutter/material.dart';

### STATE MANAGEMENT
* Menggunakan bloc sesuai yg ada di auth

### Design
- By default ketika saya membuat halaman itu diperuntukkan untuk mobile, kecuali saya meminta versi tablet atau desktop-nya
- Kalo perlu gambar dummy, gunakan placehold.co