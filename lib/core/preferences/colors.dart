import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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

  // ================================================== //
  // SHADCN SHIMMER COLORS
  // ================================================== //
  /// Shimmer base color for skeleton loading (light mode)
  static const Color shimmerBaseLight = Color(0xFFE0E0E0); // white.500

  /// Shimmer highlight color for skeleton loading (light mode)
  static const Color shimmerHighlightLight = Color(0xFFF5F5F5); // white.200

  /// Shimmer base color for skeleton loading (dark mode)
  static const Color shimmerBaseDark = Color(0xFF3C3C3C); // purple.300

  /// Shimmer highlight color for skeleton loading (dark mode)
  static const Color shimmerHighlightDark = Color(0xFF4D4D4D); // purple.100

  // ================================================== //
  // SHADCN DARK THEME COLOR SCHEME
  // ================================================== //
  static ShadSlateColorScheme get darkColorScheme => const ShadSlateColorScheme.dark(
        background: Color(0xFF1F1D2B), // purple.900
        foreground: Color(0xFFFFFFFF), // white.100
        card: Color(0xFF2B2937), // purple.700
        cardForeground: Color(0xFFFFFFFF),
        popover: Color(0xFF2B2937),
        popoverForeground: Color(0xFFFFFFFF),
        primary: Color(0xFF2196F3), // blue.500
        primaryForeground: Color(0xFFFFFFFF),
        secondary: Color(0xFF504F5E), // purple.500
        secondaryForeground: Color(0xFFFFFFFF),
        muted: Color(0xFF3C3C3C), // purple.300
        mutedForeground: Color(0xFFA1A1A1), // white.700
        accent: Color(0xFF64B5F6), // blue.300
        accentForeground: Color(0xFF000000),
        destructive: Color(0xFFF44336), // red.500
        destructiveForeground: Color(0xFFFFFFFF),
        border: Color(0xFF504F5E),
        input: Color(0xFF504F5E),
        ring: Color(0xFF2196F3),
        selection: Color(0xFF1976D2), // blue.700
      );

  // ================================================== //
  // SHADCN LIGHT THEME COLOR SCHEME
  // ================================================== //
  static ShadSlateColorScheme get lightColorScheme => const ShadSlateColorScheme.light(
        background: Color(0xFFFFFFFF), // white.100
        foreground: Color(0xFF000000), // black.900
        card: Color(0xFFF5F5F5), // white.200
        cardForeground: Color(0xFF212121), // black.500
        popover: Color(0xFFFFFFFF),
        popoverForeground: Color(0xFF212121),
        primary: Color(0xFF1D4ED8), // blue.900
        primaryForeground: Color(0xFFFFFFFF),
        secondary: Color(0xFF607D8B), // grey.500
        secondaryForeground: Color(0xFFFFFFFF),
        muted: Color(0xFFE0E0E0), // white.500
        mutedForeground: Color(0xFF616161), // black.100
        accent: Color(0xFF2196F3), // blue.500
        accentForeground: Color(0xFFFFFFFF),
        destructive: Color(0xFFD32F2F), // red.700
        destructiveForeground: Color(0xFFFFFFFF),
        border: Color(0xFFCFD8DC), // grey.100
        input: Color(0xFFCFD8DC),
        ring: Color(0xFF1D4ED8),
        selection: Color(0xFF64B5F6), // blue.300
      );

  // ================================================== //
  // HELPER METHODS
  // ================================================== //

  /// Get shimmer base color based on brightness
  static Color getShimmerBaseColor(Brightness brightness) {
    return brightness == Brightness.dark ? shimmerBaseDark : shimmerBaseLight;
  }

  /// Get shimmer highlight color based on brightness
  static Color getShimmerHighlightColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? shimmerHighlightDark
        : shimmerHighlightLight;
  }

  /// Get color scheme based on brightness
  static ShadSlateColorScheme getColorScheme(Brightness brightness) {
    return brightness == Brightness.dark ? darkColorScheme : lightColorScheme;
  }
}