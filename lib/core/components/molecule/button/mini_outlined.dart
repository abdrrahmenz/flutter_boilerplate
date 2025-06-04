import 'package:flutter/material.dart';

import '../../../core.dart';

class MiniOutlinedButton extends StatelessWidget {
  const MiniOutlinedButton({super.key, this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp20,
          vertical: Dimens.dp10,
        ),
        minimumSize: const Size(Dimens.dp100, Dimens.dp32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp8),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
