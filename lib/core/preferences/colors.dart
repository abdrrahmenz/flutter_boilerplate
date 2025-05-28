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
    100: Color(0xFFFFCDD2),
    300: Color(0xFFF44336),
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

  static const white = MaterialColor(0xFFffffff, {
    100: Color(0xFFFFFFFF),
    300: Color(0xFFF6F6F6),
    500: Color(0xFFECECEC),
    700: Color(0xFFE1E1E1),
    900: Color(0xFFD0D0D0),
  });
}