import 'package:flutter/material.dart';

import '../../../core.dart';

class MiniIconButton extends StatelessWidget {
  const MiniIconButton({
    super.key,
    required this.onTap,
    this.icon,
    this.dimension,
    this.child,
    this.radius,
    this.elevation,
    this.color,
    this.size,
  });

  final VoidCallback? onTap;
  final IconData? icon;
  final double? dimension;
  final double? radius;
  final double? elevation;
  final double? size;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension ?? Dimens.dp24,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(Dimens.dp4),
          minimumSize: Size.square(dimension ?? Dimens.dp24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? Dimens.dp50),
          ),
          elevation: elevation ?? 0,
          backgroundColor: color?.withValues(alpha: .3),
        ),
        onPressed: onTap,
        child: child ??
            Icon(
              icon,
              size: size ?? Dimens.dp14,
              color: color ?? AppColors.white,
            ),
      ),
    );
  }
}
