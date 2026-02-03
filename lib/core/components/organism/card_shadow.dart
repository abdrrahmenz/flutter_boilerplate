import 'package:flutter/material.dart';

import '../../core.dart';

class CardShadow extends StatelessWidget {
  const CardShadow({
    super.key,
    this.padding,
    this.margin,
    required this.child,
    this.radius,
    this.color,
    this.onTap,
    this.width,
    this.border,
    this.image,
    this.isShadow = true,
  });

  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget child;
  final bool isShadow;
  final double? radius;
  final Color? color;
  final VoidCallback? onTap;
  final double? width;
  final BoxBorder? border;
  final DecorationImage? image;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius ?? Dimens.radiusLg),
      child: Container(
        width: width,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: Dimens.dp20,
              vertical: Dimens.dp16,
            ),
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? colorScheme.surface,
          borderRadius: BorderRadius.circular(radius ?? Dimens.radiusLg),
          border: border,
          image: image,
          boxShadow: isShadow
              ? [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}
