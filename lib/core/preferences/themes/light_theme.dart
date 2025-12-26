import 'package:flutter/material.dart';

import '../../../app/config.dart';
import '../../core.dart';

class LightTheme {
  LightTheme(this.primaryColor);

  final Color primaryColor;
  static Color disabledTextColor = AppColors.grey[900]!;
  static Color secondaryColor = AppColors.white[700]!;
  static Color disabledColor = AppColors.white[900]!;
  static Color textSolidColor = Colors.black;
  static Color errorColor = AppColors.red;
  static Color dividerColor = AppColors.purple[500]!;
  static Color inputBackgroundColor = AppColors.white;
  static Color scaffoldColor = AppColors.white;
  static Color cardColor = AppColors.white[500]!;
  static Color appBarColor = Colors.blue;

  ColorScheme get scheme => ColorScheme.light(
        primary: primaryColor,
        surface: scaffoldColor,
        secondary: secondaryColor,
      );

  ButtonThemeData get button => ButtonThemeData(
        buttonColor: primaryColor,
        disabledColor: disabledTextColor,
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.dp8,
          horizontal: Dimens.dp24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp8),
        ),
      );

  OutlinedButtonThemeData get outlineButton => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp16),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.dp14,
            horizontal: Dimens.dp24,
          ),
          textStyle: text.labelLarge?.copyWith(color: primaryColor),
        ),
      );

  ElevatedButtonThemeData get elevatedButton => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: scaffoldColor,
          backgroundColor: primaryColor,
          disabledBackgroundColor: primaryColor.withAlpha(77),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp16),
          ),
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.dp14,
            horizontal: Dimens.dp32,
          ),
          textStyle: text.labelLarge,
        ),
      );

  CardThemeData get card => CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp8),
          side: BorderSide(
            color: dividerColor.withAlpha(77),
          ),
        ),
        color: cardColor,
      );

  AppBarTheme get appBar => AppBarTheme(
        backgroundColor: scaffoldColor,
        centerTitle: true,
        titleTextStyle: text.titleLarge?.copyWith(
          fontFamily: AppConfig.fontFamily,
          color: textSolidColor,
          fontWeight: FontWeight.w500,
          fontSize: Dimens.dp18,
        ),
        toolbarTextStyle: text.titleLarge?.copyWith(
          color: textSolidColor,
          fontFamily: AppConfig.fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        surfaceTintColor: appBarColor,
        elevation: 0,
        scrolledUnderElevation: .15,
        shadowColor: dividerColor.withAlpha(128),
        iconTheme: IconThemeData(
          color: textSolidColor,
          size: Dimens.dp24,
        ),
        actionsIconTheme: IconThemeData(
          color: textSolidColor,
          size: Dimens.dp24,
        ),
      );

  InputDecorationTheme get inputDecoration => InputDecorationTheme(
        filled: true,
        fillColor: inputBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Dimens.dp14,
          horizontal: Dimens.dp16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
          ),
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
          ),
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
      );

  BottomNavigationBarThemeData get bottomNav => BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: secondaryColor,
        selectedLabelStyle: const TextStyle(
          fontSize: Dimens.dp12,
          fontFamily: AppConfig.fontFamily,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: Dimens.dp12,
          fontFamily: AppConfig.fontFamily,
        ),
      );

  TabBarThemeData get tabBar => TabBarThemeData(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: primaryColor,
            width: Dimens.dp2,
          ),
        ),
        indicatorSize: .tab,
        labelColor: primaryColor,
        unselectedLabelColor: disabledTextColor,
        labelStyle: const TextStyle(
          fontWeight: .w600,
          fontFamily: AppConfig.fontFamily,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: .w600,
          fontFamily: AppConfig.fontFamily,
        ),
      );

  TextTheme get text => TextTheme(
        bodyLarge: TextStyle(
          color: textSolidColor,
          fontSize: Dimens.dp16,
          fontWeight: FontWeight.normal,
          fontFamily: AppConfig.fontFamily,
        ),
        // Use for regular text
        bodyMedium: TextStyle(
          color: disabledTextColor,
          fontSize: Dimens.dp14,
          fontWeight: FontWeight.normal,
          fontFamily: AppConfig.fontFamily,
        ),
        // Use for heading text
        headlineSmall: TextStyle(
          color: textSolidColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimens.dp24,
          fontFamily: AppConfig.fontFamily,
        ),
        // Use for title text, AppBar
        titleLarge: TextStyle(
          color: textSolidColor,
          fontWeight: FontWeight.w700,
          fontSize: Dimens.dp16,
          fontFamily: AppConfig.fontFamily,
        ),
        // Use for sub title text
        titleMedium: TextStyle(
          color: textSolidColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimens.dp16,
          fontFamily: AppConfig.fontFamily,
        ),

        labelLarge: const TextStyle(
          fontSize: Dimens.dp16,
          fontWeight: FontWeight.w500,
          fontFamily: AppConfig.fontFamily,
        ),
        // Use for caption
        bodySmall: TextStyle(
          fontSize: Dimens.dp10,
          fontFamily: AppConfig.fontFamily,
          color: disabledTextColor,
        ),
      );

  FloatingActionButtonThemeData get floatingButton =>
      FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        elevation: 2,
        foregroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp100),
        ),
      );

  BottomSheetThemeData get bottomSheet => BottomSheetThemeData(
        backgroundColor: scaffoldColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimens.dp20),
          ),
        ),
      );

  DividerThemeData get divider => DividerThemeData(
        color: dividerColor,
        thickness: 1,
      );

  BottomAppBarThemeData get bottomAppBarTheme => BottomAppBarThemeData(
        color: scaffoldColor,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
      );

  DialogTheme get dialogTheme {
    return DialogTheme(
      backgroundColor: scaffoldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.dp16),
      ),
      insetPadding: const EdgeInsets.all(Dimens.dp16),
    );
  }

  ThemeData get toTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConfig.fontFamily,
      bottomAppBarTheme: bottomAppBarTheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldColor,
      canvasColor: scaffoldColor,
      disabledColor: disabledColor,
      textTheme: text,
      cardTheme: card,
      appBarTheme: appBar,
      dividerColor: dividerColor,
      unselectedWidgetColor: disabledColor,
      buttonTheme: button,
      inputDecorationTheme: inputDecoration,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      outlinedButtonTheme: outlineButton,
      elevatedButtonTheme: elevatedButton,
      bottomNavigationBarTheme: bottomNav,
      tabBarTheme: tabBar,
      floatingActionButtonTheme: floatingButton,
      bottomSheetTheme: bottomSheet,
      dividerTheme: divider,
      cardColor: cardColor,
      colorScheme: scheme.copyWith(error: errorColor),
    );
  }
}
