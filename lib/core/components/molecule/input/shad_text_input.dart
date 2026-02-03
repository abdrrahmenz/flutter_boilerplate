import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../core.dart';

/// ShadCN-based text input component (replaces RegularInput)
/// Uses shadcn_ui's ShadInput with Material Design compatibility
class ShadTextInput extends StatelessWidget {
  const ShadTextInput({
    super.key,
    this.obscureText = false,
    this.focusNode,
    this.hintText,
    this.suffix,
    this.prefixIcon,
    this.controller,
    this.errorText,
    this.minLine = 1,
    this.maxLine = 1,
    this.onChange,
    this.onSubmit,
    this.inputAction,
    this.inputType,
    this.enable = true,
    this.onTap,
    this.readOnly,
    this.inputFormatters,
    this.maxLength,
    this.autoFocus,
    this.label,
    this.prefix,
    this.isRequired,
    this.description,
  });

  final IconData? prefixIcon;
  final bool enable;
  final bool? obscureText, readOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, errorText;
  final Widget? suffix;
  final int minLine, maxLine;
  final ValueChanged<String>? onChange, onSubmit;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? autoFocus;
  final String? label;
  final Widget? prefix;
  final bool? isRequired;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(label!, style: context.subtitle1),
              if (isRequired == true) ...[
                const SizedBox(width: Dimens.dp8),
                Text(
                  'Required',
                  style: context.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.error,
                    fontSize: Dimens.dp10,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: Dimens.dp8),
        ],
        if (description != null) ...[
          Text(
            description!,
            style: context.muted,
          ),
          const SizedBox(height: Dimens.dp8),
        ],
        ShadInput(
          controller: controller,
          focusNode: focusNode,
          placeholder: Text(hintText ?? ''),
          obscureText: obscureText ?? false,
          minLines: minLine,
          maxLines: maxLine,
          maxLength: maxLength,
          onChanged: onChange,
          onSubmitted: onSubmit,
          textInputAction: inputAction ?? TextInputAction.done,
          keyboardType: inputType,
          enabled: enable,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatters,
          autofocus: autoFocus ?? false,
          leading: prefix ?? (prefixIcon != null ? Icon(prefixIcon, size: 18) : null),
          trailing: suffix,
          onPressed: onTap,
        ),
        if (errorText != null) ...[
          const SizedBox(height: Dimens.dp4),
          Text(
            errorText!,
            style: context.caption?.copyWith(
              color: context.theme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}
