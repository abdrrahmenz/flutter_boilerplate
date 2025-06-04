import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  // ------------------------------------------------- //
  // Color's pallete from https://materialui.co/colors/
  // ------------------------------------------------- //
  static const black = MaterialColor(0xFF000000, {
    100: Color(0xFF616161),
    300: Color(0xFF424242),
    500: Color(0xFF212121),
    700: Color(0xFF121212),
    900: Color(0xFF000000),
  });

  static const blue = MaterialColor(0xFF1D4ED8, {
    100: Color(0xFFBBDEFB),
    300: Color(0xFF64B5F6),
    500: Color(0xFF2196F3),
    700: Color(0xFF1976D2),
    900: Color(0xFF1D4ED8),
  });

  static const grey = MaterialColor(0xFF263238, {
    100: Color(0xFFCFD8DC),
    300: Color(0xFF90A4AE),
    500: Color(0xFF607D8B),
    700: Color(0xFF455A64),
    900: Color(0xFF263238),
  });

  static const red = MaterialColor(0xFFB71C1C, {
    50: Color(0xFFFFEBCD), // Warna lebih terang
    100: Color(0xFFFF8A00), // Warna lebih terang
    150: Color(0xFFF79A10), // Warna lebih terang
    200: Color(0xFFFEB8B8), // Warna lebih terang
    300: Color(0xFFFF5C00), // Warna menengah
    500: Color(0xFFF44336),
    700: Color(0xFFD32F2F),
    900: Color(0xFFB71C1C),
  });

  static const purple = MaterialColor(0xFF1F1D2B, {
    100: Color(0xFF4D4D4D),
    300: Color(0xFF3C3C3C),
    500: Color(0xFF504F5E),
    700: Color(0xFF2B2937),
    900: Color(0xFF1F1D2B),
  });

// Warna aktif untuk sholat
  static const white = MaterialColor(0xFFFFFFFF, {
    100: Color(0xFFFFFFFF), // Warna lebih terang untuk state aktif
    200: Color(0xFFF5F5F5), // Warna untuk dp angsuran paket
    300: Color(0xFFFBF3F2), // Warna menengah
    400: Color(0xFFF2F2F2), // Warna menengah
    500: Color(0xFFE0E0E0), // Warna utama
    700: Color(0xFFA1A1A1), // Warna lebih gelap
    900: Color(0xFF828282), // Warna tergelap
  });
}