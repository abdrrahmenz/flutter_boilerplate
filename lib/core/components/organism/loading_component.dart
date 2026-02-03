import 'package:flutter/material.dart';

import '../../core.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const CircularProgressIndicator(),
            Dimens.dp16.height,
            Text('Loading...', style: context.bodyLarge),
          ],
        ),
      ),
    );
  }
}
