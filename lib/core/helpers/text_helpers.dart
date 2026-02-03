import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Text style helper extensions for BuildContext
/// Provides convenient access to themed text styles with Geist font
/// 
/// Replaces old text components (HeadingText, RegularText, SubTitleText, TitleText)
/// with direct Text widget usage and theme-based styles
/// 
/// Example usage:
/// ```dart
/// // Instead of: HeadingText('Welcome')
/// Text('Welcome', style: context.h1)
/// 
/// // Instead of: RegularText('Description')
/// Text('Description', style: context.bodyMedium)
/// 
/// // Instead of: SubTitleText('Subtitle')
/// Text('Subtitle', style: context.h3)
/// ```
extension TextStyleHelpers on BuildContext {
  /// Get the current theme data
  ThemeData get _themeData => Theme.of(this);

  /// Get shadcn theme if available
  ShadThemeData? get shadTheme => ShadTheme.maybeOf(this);

  /// Get text theme
  TextTheme get textTheme => _themeData.textTheme;

  // ================================================== //
  // HEADING STYLES (H1-H4)
  // ================================================== //

  /// Heading 1 - Largest heading (headlineLarge)
  /// Equivalent to old HeadingText with largest size
  /// Usage: Text('Title', style: context.h1)
  TextStyle? get h1 => textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        fontFamily: 'Geist',
      );

  /// Heading 2 - Medium large heading (headlineMedium)
  /// Equivalent to old HeadingText with medium size
  /// Usage: Text('Section Title', style: context.h2)
  TextStyle? get h2 => textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontFamily: 'Geist',
      );

  /// Heading 3 - Small heading (headlineSmall)
  /// Equivalent to old HeadingText default or SubTitleText large
  /// Usage: Text('Subsection', style: context.h3)
  TextStyle? get h3 => textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontFamily: 'Geist',
      );

  /// Heading 4 - Title size heading (titleLarge)
  /// Equivalent to old TitleText
  /// Usage: Text('Card Title', style: context.h4)
  TextStyle? get h4 => textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontFamily: 'Geist',
      );

  // ================================================== //
  // BODY TEXT STYLES
  // ================================================== //

  /// Body large - Larger body text (bodyLarge)
  /// Equivalent to old RegularText.large()
  /// Usage: Text('Important content', style: context.bodyLarge)
  TextStyle? get bodyLarge => textTheme.bodyLarge?.copyWith(
        fontFamily: 'Geist',
      );

  /// Body medium - Standard body text (bodyMedium)
  /// Equivalent to old RegularText() default
  /// Usage: Text('Normal text', style: context.bodyMedium)
  TextStyle? get bodyMedium => textTheme.bodyMedium?.copyWith(
        fontFamily: 'Geist',
      );

  /// Body small - Smaller body text (bodySmall)
  /// Equivalent to old RegularText.small()
  /// Usage: Text('Small text', style: context.bodySmall)
  TextStyle? get bodySmall => textTheme.bodySmall?.copyWith(
        fontFamily: 'Geist',
      );

  // ================================================== //
  // SUBTITLE STYLES
  // ================================================== //

  /// Subtitle 1 - Larger subtitle (titleMedium)
  /// Equivalent to old SubTitleText default
  /// Usage: Text('Subtitle', style: context.subtitle1)
  TextStyle? get subtitle1 => textTheme.titleMedium?.copyWith(
        fontFamily: 'Geist',
      );

  /// Subtitle 2 - Smaller subtitle (titleSmall)
  /// Equivalent to old SubTitleText with smaller size
  /// Usage: Text('Small subtitle', style: context.subtitle2)
  TextStyle? get subtitle2 => textTheme.titleSmall?.copyWith(
        fontFamily: 'Geist',
      );

  // ================================================== //
  // SPECIALIZED TEXT STYLES
  // ================================================== //

  /// Muted text - De-emphasized text with reduced opacity
  /// Uses shadcn mutedForeground color for consistency
  /// Usage: Text('Helper text', style: context.muted)
  TextStyle? get muted => textTheme.bodyMedium?.copyWith(
        fontFamily: 'Geist',
        color: shadTheme?.colorScheme.mutedForeground ??
            _themeData.colorScheme.onSurface.withValues(alpha: 0.6),
      );

  /// Label text - For form labels and buttons (labelLarge)
  /// Equivalent to old label style in forms
  /// Usage: Text('Form Label', style: context.label)
  TextStyle? get label => textTheme.labelLarge?.copyWith(
        fontFamily: 'Geist',
        fontWeight: FontWeight.w500,
      );

  /// Caption text - Smallest text size (bodySmall with reduced opacity)
  /// For captions, timestamps, metadata
  /// Usage: Text('2 hours ago', style: context.caption)
  TextStyle? get caption => textTheme.bodySmall?.copyWith(
        fontFamily: 'Geist',
        color: _themeData.colorScheme.onSurface.withValues(alpha: 0.5),
      );

  /// Button text - For button labels (labelLarge)
  /// Usage: Text('Submit', style: context.buttonText)
  TextStyle? get buttonText => textTheme.labelLarge?.copyWith(
        fontFamily: 'Geist',
        fontWeight: FontWeight.w600,
      );

  // ================================================== //
  // UTILITY COLORS
  // ================================================== //

  /// Get primary color from theme
  Color get primaryColor => _themeData.colorScheme.primary;

  /// Get error color from theme
  Color get errorColor => _themeData.colorScheme.error;

  /// Get surface color from theme
  Color get surfaceColor => _themeData.colorScheme.surface;

  /// Get background color from theme
  Color get backgroundColor =>
      shadTheme?.colorScheme.background ?? _themeData.scaffoldBackgroundColor;

  /// Get foreground color from theme
  Color get foregroundColor =>
      shadTheme?.colorScheme.foreground ?? _themeData.colorScheme.onSurface;
}
