import 'package:flutter/material.dart';
import '../../../core.dart';

/// ShadCN-based search input component (replaces SearchTextInput)
/// Uses ShadTextInput with search icon
class ShadSearchInput extends StatelessWidget {
  const ShadSearchInput({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.label,
    this.errorText,
    this.description,
    this.onChange,
    this.onSubmit,
    this.autoFocus,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? label;
  final String? errorText;
  final String? description;
  final ValueChanged<String>? onChange, onSubmit;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return ShadTextInput(
      controller: controller,
      focusNode: focusNode,
      hintText: hintText ?? 'Search...',
      label: label,
      errorText: errorText,
      description: description,
      onChange: onChange,
      onSubmit: onSubmit,
      autoFocus: autoFocus,
      prefixIcon: Icons.search,
      inputType: TextInputType.text,
      inputAction: TextInputAction.search,
    );
  }
}
