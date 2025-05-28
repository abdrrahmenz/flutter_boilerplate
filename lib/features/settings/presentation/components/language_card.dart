import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    this.isActive = false,
    required this.image,
    required this.country,
    this.onPressed,
  });

  final bool isActive;
  final String image, country;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        border: Border.all(
          color: context.adaptiveTheme.tertiaryColor.withAlpha(77),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCheck(context),
              const SizedBox(width: Dimens.dp24),
              _buildFlag(),
              const SizedBox(width: Dimens.dp12),
              SubTitleText(
                country,
                style: const TextStyle(fontSize: Dimens.dp12),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheck(BuildContext context) {
    return isActive
        ? Icon(
            Icons.check_circle,
            size: Dimens.dp20,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.lens,
            color: context.adaptiveTheme.tertiaryColor.withAlpha(128),
            size: Dimens.dp20,
          );
  }

  Widget _buildFlag() {
    return Image.asset(
      image,
      fit: BoxFit.cover,
      width: Dimens.dp16,
      height: Dimens.dp12,
    );
  }
}
