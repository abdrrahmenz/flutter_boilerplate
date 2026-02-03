import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core.dart';

class EditableTextInput extends StatelessWidget {
  const EditableTextInput({
    super.key,
    this.readOnly = false,
    this.hint,
    this.onTap,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.formatters,
    required this.label,
  });

  final bool readOnly;
  final String label;
  final String? hint;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    final divider = context.theme.dividerColor;
    final disabled = context.theme.disabledColor;
    final style = context.adaptiveTheme.titleTextStyle;
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.dp16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp16,
          vertical: Dimens.dp8,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: divider, width: 2),
          borderRadius: BorderRadius.circular(Dimens.dp16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimens.dp6.height,
            Text(label, style: context.bodyLarge),
            TextField(
              controller: controller,
              style: style,
              selectionControls: CupertinoTextSelectionControls(),
              readOnly: readOnly,
              onTap: onTap,
              onChanged: onChanged,
              keyboardType: keyboardType,
              inputFormatters: formatters,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hint,
                hintStyle: style?.copyWith(color: disabled),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
