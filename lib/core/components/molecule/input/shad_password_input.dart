import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core.dart';

/// ShadCN-based password input component (replaces PasswordInput)
/// Uses ShadTextInput with visibility toggle
class ShadPasswordInput extends StatefulWidget {
  const ShadPasswordInput({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.label,
    this.errorText,
    this.description,
    this.inputFormatters,
    this.onChange,
    this.onSubmit,
    this.inputAction,
    this.inputType,
    this.maxLength,
    this.isRequired,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? label;
  final String? errorText;
  final String? description;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChange, onSubmit;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final int? maxLength;
  final bool? isRequired;

  @override
  State<ShadPasswordInput> createState() => _ShadPasswordInputState();
}

class _ShadPasswordInputState extends State<ShadPasswordInput> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return ShadTextInput(
      prefixIcon: Icons.lock,
      errorText: widget.errorText,
      description: widget.description,
      controller: widget.controller,
      hintText: widget.hintText,
      label: widget.label,
      isRequired: widget.isRequired,
      focusNode: widget.focusNode,
      inputAction: widget.inputAction,
      inputFormatters: widget.inputFormatters,
      onChange: widget.onChange,
      onSubmit: widget.onSubmit,
      inputType: widget.inputType ?? TextInputType.visiblePassword,
      maxLength: widget.maxLength,
      obscureText: !isVisible,
      suffix: _buildSuffix(),
    );
  }

  Widget _buildSuffix() {
    return InkWell(
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      borderRadius: BorderRadius.circular(Dimens.dp100),
      child: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: Dimens.dp18,
      ),
    );
  }
}
