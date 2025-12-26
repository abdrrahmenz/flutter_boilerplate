import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: Column(
          children: [
            SvgPicture.asset(
              MainAssets.placeholder,
              width: Dimens.width(context) * .3,
            ),
            Dimens.dp24.height,
            RegularText.normal(
              context,
              message ?? 'Tidak ada data ditemukan!',
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
