import 'package:flutter/material.dart';

import '../../core.dart';

class CardTicket extends StatelessWidget {
  const CardTicket({
    super.key,
    required this.child,
    this.positionHeight,
    this.margin,
    this.padding,
  });
  final Widget child;
  final double? positionHeight;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            horizontal: Dimens.dp16,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.dp16),
        boxShadow: [
          BoxShadow(
            color: context.theme.dividerColor,
            offset: const Offset(3, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipPath(
        clipBehavior: Clip.hardEdge,
        clipper: TicketClipper(positionHeight),
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.dp24,
                vertical: Dimens.dp16,
              ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.dp16),
            color: context.theme.scaffoldBackgroundColor,
          ),
          child: child,
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double? positionHeight;

  TicketClipper(this.positionHeight);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ),
    );
    path.addOval(
      Rect.fromCircle(center: Offset(0, positionHeight ?? 112), radius: 16),
    );
    path.addOval(
      Rect.fromCircle(
          center: Offset(size.width, positionHeight ?? 112), radius: 16),
    );
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
