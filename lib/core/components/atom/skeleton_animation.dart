import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/core.dart';

class SkeletonAnimation extends StatelessWidget {
  const SkeletonAnimation({
    super.key,
    this.backgroundColor,
    this.width,
    this.height,
    this.radius,
    this.child,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
  });

  final Color? backgroundColor;
  final Color? baseColor;
  final Color? highlightColor;
  final double? width;
  final double? height;
  final double? radius;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          baseColor ?? context.adaptiveTheme.solidTextColor!.withAlpha(26),
      highlightColor:
          highlightColor ?? context.adaptiveTheme.solidTextColor!.withAlpha(51),
      child: child ??
          Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color:
                  backgroundColor ?? context.theme.disabledColor.withAlpha(128),
              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 16),
            ),
          ),
    );
  }
}
