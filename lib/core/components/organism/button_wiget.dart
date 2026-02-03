import 'package:flutter/material.dart';

import '../../core.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.onPressed,
    this.child,
    this.text,
    this.textStyle,
    this.bgColor,
    this.gradientColor,
    this.width,
    this.height,
    this.isDisable = false,
    this.isLoading = false,
    this.suffixIcon,
    this.prefixIcon,
    this.radius,
    this.bgIsLoading,
    this.borderColor,
    this.useBorder = false,
    this.shadows,
    this.borderWidth,
  });

  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final TextStyle? textStyle;
  final Color? bgColor, bgIsLoading, borderColor;
  final LinearGradient? gradientColor;
  final double? width;
  final double? height;
  final bool isDisable, isLoading, useBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? radius, borderWidth;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    var bgColored = bgColor != null
        ? (isDisable || isLoading ? bgColor : bgColor)
        : (isDisable || isLoading ? context.theme.primaryColor : null);
    if (bgIsLoading != null && isLoading) bgColored = bgIsLoading;
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: bgColor == null && !isDisable && !isLoading
            ? gradientColor ??
                const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFE82320), Color(0xfffa504d)],
                )
            : null,
        color: bgColored,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 16)),
        border: useBorder
            ? Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 2,
              )
            : null,
        boxShadow: shadows ??
            [
              BoxShadow(
                color:
                    bgColored ?? const Color(0xFF000000).withValues(alpha: 1),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -3.5,
              ),
            ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: height ?? 48,
        ),
        child: ElevatedButton(
          onPressed: isDisable ? null : onPressed,
          style: ButtonStyle(
            padding:
                WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
            elevation: WidgetStateProperty.all<double>(0),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shape: WidgetStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (prefixIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: prefixIcon,
                      ),
                    Text(
                      text ?? '',
                      style: textStyle ??
                          context.bodyMedium?.copyWith(
                            color: AppColors.white,
                            fontWeight: .w600,
                            fontSize: Dimens.dp18,
                          ),
                    ),
                    if (suffixIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: suffixIcon,
                      )
                  ],
                ),
        ),
      ),
    );
  }
}
