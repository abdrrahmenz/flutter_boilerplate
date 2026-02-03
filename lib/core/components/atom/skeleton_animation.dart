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
    final brightness = Theme.of(context).brightness;
    
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.getShimmerBaseColor(brightness),
      highlightColor: highlightColor ?? AppColors.getShimmerHighlightColor(brightness),
      child: child ??
          Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.getShimmerBaseColor(brightness),
              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 16),
            ),
          ),
    );
  }
}
