import 'package:flutter/material.dart';
import '../../core.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    this.label,
    this.isRequired,
  });

  final String? label;
  final bool? isRequired;
  @override
  Widget build(BuildContext context) {
    if (label == null) return const SizedBox();
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            SubTitleText(label ?? ''),
            const SizedBox(width: Dimens.dp8),
            if (isRequired == true)
              RegularText(
                'Required',
                style: TextStyle(
                  color: context.adaptiveTheme.primaryColor,
                  fontSize: Dimens.dp10,
                ),
              )
          ],
        ),
        const SizedBox(height: Dimens.dp8),
      ],
    );
  }
}
