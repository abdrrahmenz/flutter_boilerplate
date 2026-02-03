import 'package:flutter/material.dart';

/// Helper functions to generate FormZ error message maps for i18n support
/// Maps FormZ error enums to localized strings from AppLocalizations
class FormzErrorMessages {
  const FormzErrorMessages._();

  /// Generate error messages map for email input validation
  /// Usage: FormzShadInput with EmailInput errorMessages: emailErrorMessages(context)
  static Map<dynamic, String> emailErrorMessages(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;
    return {
      'empty': 'Email is required', // TODO: l10n.fieldRequired
      'invalid': 'Please enter a valid email', // TODO: l10n.invalidEmail
    };
  }

  /// Generate error messages map for password input validation
  /// Usage: FormzShadInput with PasswordInput errorMessages: passwordErrorMessages(context)
  static Map<dynamic, String> passwordErrorMessages(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;
    return {
      'empty': 'Password is required', // TODO: l10n.fieldRequired
      'tooShort': 'Password must be at least 6 characters', // TODO: l10n.passwordTooShort
    };
  }

  /// Generate error messages map for required field validation
  /// Usage: FormzShadInput with RequiredInput errorMessages: requiredErrorMessages(context)
  static Map<dynamic, String> requiredErrorMessages(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;
    return {
      'empty': 'This field is required', // TODO: l10n.fieldRequired
    };
  }

  /// Generate error messages map for name input validation
  /// Usage: FormzShadInput with NameInput errorMessages: nameErrorMessages(context)
  static Map<dynamic, String> nameErrorMessages(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;
    return {
      'empty': 'Name is required', // TODO: l10n.fieldRequired
      'invalid': 'Please enter a valid name', // TODO: l10n.invalidName
    };
  }

  /// Generate error messages map for phone input validation
  /// Usage: FormzShadInput with PhoneInput errorMessages: phoneErrorMessages(context)
  static Map<dynamic, String> phoneErrorMessages(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;
    return {
      'empty': 'Phone number is required', // TODO: l10n.fieldRequired
      'invalid': 'Please enter a valid phone number', // TODO: l10n.invalidPhone
    };
  }

  /// Generate error messages map for confirmation password validation
  /// Usage: FormzShadInput with ConfirmPasswordInput errorMessages: confirmPasswordErrorMessages(context)
  static Map<dynamic, String> confirmPasswordErrorMessages(
    BuildContext context,
  ) {
    // final l10n = AppLocalizations.of(context)!;
    return {
      'empty': 'Confirmation password is required', // TODO: l10n.fieldRequired
      'mismatch': 'Passwords do not match', // TODO: l10n.passwordMismatch
    };
  }

  /// Generic helper to get error message from map or return default
  /// Falls back to error.toString() if key not found in errorMessages
  static String getErrorMessage(
    dynamic error,
    Map<dynamic, String>? errorMessages,
  ) {
    if (errorMessages == null) return error.toString();
    
    // Try to get by exact match first
    if (errorMessages.containsKey(error)) {
      return errorMessages[error]!;
    }
    
    // Try to get by toString() match (for enums)
    final errorString = error.toString();
    final key = errorMessages.keys.firstWhere(
      (k) => k.toString() == errorString,
      orElse: () => null,
    );
    
    return key != null ? errorMessages[key]! : errorString;
  }
}
