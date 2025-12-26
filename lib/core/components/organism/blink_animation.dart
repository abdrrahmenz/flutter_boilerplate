import 'package:flutter/material.dart';

class BlinkAnimation extends StatefulWidget {
  final Widget child;

  const BlinkAnimation({
    super.key,
    required this.child,
  });

  @override
  State<BlinkAnimation> createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<BlinkAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
