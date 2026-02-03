import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../helpers/formz_error_messages.dart';

/// Generic FormZ wrapper for ShadInput component
/// Provides seamless integration between FormZ validation and shadcn_ui inputs
/// 
/// Type parameter T must extend FormzInput for validation support
/// 
/// Example usage:
/// ```dart
/// FormzShadInput<EmailInput>(
///   input: state.email,
///   label: 'Email',
///   placeholder: 'Enter your email',
///   errorMessages: FormzErrorMessages.emailErrorMessages(context),
///   onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
/// )
/// ```
class FormzShadInput<T extends FormzInput<dynamic, dynamic>>
    extends StatelessWidget {
  const FormzShadInput({
    super.key,
    required this.input,
    this.label,
    this.placeholder,
    this.description,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.decoration,
    this.errorMessages,
    this.controller,
    this.focusNode,
  });

  /// FormZ input instance containing value and validation state
  final T input;

  /// Input label text
  final String? label;

  /// Placeholder text shown when input is empty
  final String? placeholder;

  /// Helper text shown below the input
  final String? description;

  /// Widget shown before the input text (e.g., icon)
  final Widget? prefix;

  /// Widget shown after the input text (e.g., icon button)
  final Widget? suffix;

  /// Whether to obscure the text (for passwords)
  final bool obscureText;

  /// Whether the input is enabled
  final bool enabled;

  /// Whether the input is read-only
  final bool readOnly;

  /// Whether the input should auto-focus
  final bool autofocus;

  /// Maximum number of lines
  final int? maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum character length
  final int? maxLength;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action button
  final TextInputAction? textInputAction;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Callback when user submits (e.g., presses enter/done)
  final ValueChanged<String>? onSubmitted;

  /// Callback when input is tapped
  final VoidCallback? onTap;

  /// Advanced decoration configuration (overrides individual props if provided)
  final ShadDecoration? decoration;

  /// Map of error enums to localized error messages
  /// Use FormzErrorMessages helpers for i18n support
  final Map<dynamic, String>? errorMessages;

  /// Optional external text controller
  final TextEditingController? controller;

  /// Optional external focus node
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    // Get error message if input is invalid
    final errorText = input.isPure || input.isValid
        ? null
        : FormzErrorMessages.getErrorMessage(
            input.error,
            errorMessages,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(label!, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ShadInput(
          controller: controller,
          focusNode: focusNode,
          placeholder: placeholder != null ? Text(placeholder!) : null,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: decoration,
          initialValue: controller == null ? input.value.toString() : null,
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              description!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
      ],
    );
  }
}

/// Password input variant with show/hide toggle
/// Extends FormzShadInput with built-in obscureText toggle functionality
/// 
/// Example usage:
/// ```dart
/// PasswordShadInput(
///   input: state.password,
///   label: 'Password',
///   placeholder: 'Enter your password',
///   errorMessages: FormzErrorMessages.passwordErrorMessages(context),
///   onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(value)),
/// )
/// ```
class PasswordShadInput<T extends FormzInput<dynamic, dynamic>>
    extends StatefulWidget {
  const PasswordShadInput({
    super.key,
    required this.input,
    this.label,
    this.placeholder,
    this.description,
    this.prefix,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.errorMessages,
    this.controller,
    this.focusNode,
  });

  final T input;
  final String? label;
  final String? placeholder;
  final String? description;
  final Widget? prefix;
  final bool enabled;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Map<dynamic, String>? errorMessages;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  State<PasswordShadInput<T>> createState() => _PasswordShadInputState<T>();
}

class _PasswordShadInputState<T extends FormzInput<dynamic, dynamic>>
    extends State<PasswordShadInput<T>> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormzShadInput<T>(
      input: widget.input,
      label: widget.label,
      placeholder: widget.placeholder,
      description: widget.description,
      obscureText: _obscureText,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      errorMessages: widget.errorMessages,
      controller: widget.controller,
      focusNode: widget.focusNode,
      suffix: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: _toggleObscureText,
        iconSize: 20,
      ),
    );
  }
}

/// Search input variant with search icon prefix
/// Extends FormzShadInput with built-in search icon
/// 
/// Example usage:
/// ```dart
/// SearchShadInput(
///   input: state.searchQuery,
///   placeholder: 'Search...',
///   onChanged: (value) => context.read<SearchBloc>().add(SearchChanged(value)),
/// )
/// ```
class SearchShadInput<T extends FormzInput<dynamic, dynamic>>
    extends StatelessWidget {
  const SearchShadInput({
    super.key,
    required this.input,
    this.label,
    this.placeholder,
    this.description,
    this.enabled = true,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.errorMessages,
    this.controller,
    this.focusNode,
  });

  final T input;
  final String? label;
  final String? placeholder;
  final String? description;
  final bool enabled;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Map<dynamic, String>? errorMessages;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return FormzShadInput<T>(
      input: input,
      label: label,
      placeholder: placeholder ?? 'Search...',
      description: description,
      enabled: enabled,
      autofocus: autofocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorMessages: errorMessages,
      controller: controller,
      focusNode: focusNode,
      prefix: const Padding(
        padding: EdgeInsets.only(left: 12, right: 8),
        child: Icon(Icons.search, size: 20),
      ),
    );
  }
}
