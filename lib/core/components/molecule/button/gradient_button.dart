import 'package:flutter/material.dart';

import '../../../core.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.onTap,
    this.text,
    this.padding,
    this.radius,
    this.fontSize,
  });

  final VoidCallback? onTap;
  final String? text;
  final EdgeInsets? padding;
  final double? radius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final white = context.theme.scaffoldBackgroundColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: Dimens.dp16,
              vertical: Dimens.dp8,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Dimens.dp8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.red[400]!, AppColors.red[900]!],
          ),
        ),
        child: Center(
          child: Text(
            text ?? 'Tambah',
            style: context.subtitle1?.copyWith(
              fontSize: fontSize ?? Dimens.dp12,
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
