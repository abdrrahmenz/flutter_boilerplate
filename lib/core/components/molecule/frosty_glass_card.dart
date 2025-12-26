import 'dart:ui';

import 'package:flutter/material.dart';

class FrostyGlassCard extends StatelessWidget {
  const FrostyGlassCard({
    super.key,
    this.color = Colors.white,
    this.borderRadius,
    this.border,
    this.child,
  });

  final Color color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            border: border,
            color: color.withAlpha(102),
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
