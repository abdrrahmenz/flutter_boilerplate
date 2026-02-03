import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core.dart';

class SoonPage extends StatelessWidget {
  const SoonPage({super.key, required this.title});
  final String title;

  static const String routeName = '/soon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SvgPicture.asset(
                MainAssets.emptySvg,
                width: Dimens.width(context) * .7,
              ),
              Dimens.dp40.height,
              Text(
                'Masih Dalam Pengembangan',
                style: context.h3,
                textAlign: .center,
              ),
              Dimens.dp16.height,
              Text(
                'Maaf konten ini masih dalam perkembangan, tetap tunggu dan nantikan update update dari kami.',
                style: context.bodyLarge,
                textAlign: .center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
