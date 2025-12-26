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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius ?? Dimens.dp24),
      child: Container(
        width: width,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: Dimens.dp20,
              vertical: Dimens.dp16,
            ),
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(radius ?? Dimens.dp24),
          border: border,
          image: image,
          boxShadow: (radius ?? 0) == 0
              ? isShadow
                  ? [
                      BoxShadow(
                        color: context.theme.dividerColor.withValues(alpha: .5),
                        offset: const Offset(3, 5),
                        blurRadius: 10,
                      ),
                    ]
                  : null
              : isShadow == false
                  ? null
                  : [
                      BoxShadow(
                        color: context.theme.dividerColor.withValues(alpha: .5),
                        offset: const Offset(3, 5),
                        blurRadius: 10,
                      ),
                    ],
        ),
        child: child,
      ),
    );
  }
}
