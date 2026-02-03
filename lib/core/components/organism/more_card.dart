import 'package:flutter/material.dart';

import '../../core.dart';

class MoreCardButton extends StatelessWidget {
  const MoreCardButton({
    super.key,
    this.onTap,
    this.child,
    this.text,
    this.textColor,
    this.bgColor,
    this.radius,
    this.padding,
    this.show = false,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final String? text;
  final String? textColor;
  final String? bgColor;
  final EdgeInsets? padding;
  final double? radius;
  final bool show;

  @override
  Widget build(BuildContext context) {
    final primary = context.theme.primaryColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(Dimens.dp12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? Dimens.dp16),
            color: (bgColor != null && bgColor!.isNotEmpty)
                ? Color(
                    int.parse(bgColor!.substring(1), radix: 16) + 0xFF000000)
                : AppColors.red[300],
            boxShadow: [
              BoxShadow(
                color: context.theme.dividerColor,
                offset: const Offset(-3, -7),
                blurRadius: 10,
              ),
            ]),
        child: child ??
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  text ?? '-',
                  style: context.subtitle1?.copyWith(
                    color: (textColor != null && textColor!.isNotEmpty)
                        ? Color(int.parse(textColor!.substring(1), radix: 16) +
                            0xFF000000)
                        : AppColors.red,
                  ),
                ),
                Icon(
                  show
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: primary,
                ),
              ],
            ),
      ),
    );
  }
}
