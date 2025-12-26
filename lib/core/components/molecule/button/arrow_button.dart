import 'package:flutter/material.dart';

import '../../../core.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({super.key, required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(Dimens.dp6),
        minimumSize: const Size.square(Dimens.dp32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp100),
        ),
      ),
      onPressed: onTap,
      child: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: Dimens.dp20,
        color: AppColors.white,
      ),
    );
  }
}
