import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/core.dart';

class ButtonActionConfirm extends StatelessWidget {
  const ButtonActionConfirm({super.key, this.onCancel, this.onConfirm});

  final void Function()? onCancel;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShadButton.outline(
            onPressed: onCancel,
            child: Text(
              'Cancel',
              style: context.bodyMedium?.copyWith(
                fontWeight: .w600,
              ),
            ),
          ),
        ),
        Dimens.dp14.width,
        Expanded(
          child: ShadButton(
            onPressed: onConfirm,
            child: Text(
              'Yes',
              style: context.bodyMedium?.copyWith(
                fontWeight: .w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
