import 'package:flutter/material.dart';

import '../../../core.dart';

class MiniElevatedButton extends StatelessWidget {
  const MiniElevatedButton({
    super.key,
    this.onPressed,
    required this.child,
    this.shape,
    this.color,
    this.padding,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final OutlinedBorder? shape;
  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: Dimens.dp20,
              vertical: Dimens.dp10,
            ),
        minimumSize: const Size(Dimens.dp100, Dimens.dp32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp8),
        ),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
