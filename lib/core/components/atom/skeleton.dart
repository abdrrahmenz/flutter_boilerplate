import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.backgroundColor,
    this.width,
    this.height,
    this.radius,
  });

  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final defaultColor = brightness == Brightness.dark
        ? AppColors.purple[300]!
        : AppColors.white[500]!;
    
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 4),
        color: backgroundColor ?? defaultColor,
      ),
    );
  }
}
