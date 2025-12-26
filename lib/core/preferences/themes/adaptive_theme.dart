import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdaptiveTheme extends Equatable {
  const AdaptiveTheme({required this.themeData});

  final ThemeData themeData;

  // Text Style
  TextStyle? get headingTextStyle => themeData.textTheme.headlineSmall;

  TextStyle? get titleTextStyle => themeData.textTheme.titleLarge;

  TextStyle? get subTitleTextStyle => themeData.textTheme.titleMedium;

  TextStyle? get labelTextStyle => themeData.textTheme.bodyLarge;

  TextStyle? get regularTextStyle => themeData.textTheme.bodyMedium;

  TextStyle? get captionTextStyle => themeData.textTheme.bodySmall;

  TextStyle? get buttonTextStyle => themeData.textTheme.labelLarge;

  // Color
  Color get primaryColor => themeData.colorScheme.primary;

  Color get backgroundColor => themeData.scaffoldBackgroundColor;

  Color get disabledColor => themeData.disabledColor;

  Color get tertiaryColor => themeData.dividerColor;

  // Text Color
  Color? get solidTextColor => titleTextStyle?.color;

  Color? get regularTextColor => regularTextStyle?.color;

  Color? get tertiaryTextColor => regularTextStyle?.color;

  Color? get placeholderTextColor =>
      themeData.inputDecorationTheme.hintStyle?.color;

  @override
  List<Object?> get props => [themeData];
}