import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core.dart';

enum AppTheme {
  @JsonValue('light')
  light,

  @JsonValue('dark')
  dark
}

extension AppThemeX on AppTheme {
  String toText() {
    return name;
  }

  ThemeData toThemeData() {
    switch (this) {
      case AppTheme.dark:
        return DarkTheme(Colors.blue).toTheme;
      case AppTheme.light:
        return LightTheme(AppColors.blue).toTheme;
    }
  }
}
