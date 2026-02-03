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
            Text(label ?? '', style: context.label),
            const SizedBox(width: Dimens.dp8),
            if (isRequired == true)
              Text(
                'Required',
                style: context.caption?.copyWith(
                  color: context.theme.colorScheme.primary,
                ),
              )
          ],
        ),
        const SizedBox(height: Dimens.dp8),
      ],
    );
  }
}
