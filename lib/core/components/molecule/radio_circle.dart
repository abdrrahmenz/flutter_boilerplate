import 'package:flutter/material.dart';

import '../../core.dart';

class RadioCircle extends StatelessWidget {
  const RadioCircle({super.key, this.isActive = false});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final primary = context.theme.primaryColor;

    return Container(
      width: Dimens.dp22,
      height: Dimens.dp22,
      padding: const EdgeInsets.all(Dimens.dp2),
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? primary : context.theme.dividerColor,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: isActive
          ? Container(
              decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
            )
          : null,
    );
  }
}
