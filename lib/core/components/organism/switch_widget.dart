import 'package:flutter/material.dart';

import '../../core.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
    this.withText = false,
    this.isActive = false,
    this.onChanged,
    this.colorActive,
  });
  final bool withText;
  final bool isActive;
  final Color? colorActive;
  final void Function(bool)? onChanged;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call onChanged with the new toggled state
        widget.onChanged?.call(!widget.isActive);
      },
      child: Container(
        padding: const EdgeInsets.all(Dimens.dp2),
        width: widget.withText ? Dimens.dp50 : Dimens.dp64,
        height: widget.withText ? Dimens.dp20 : Dimens.dp32,
        decoration: BoxDecoration(
          color: (widget.isActive && widget.colorActive == null)
              ? context.theme.primaryColor
              : AppColors.white[500],
          gradient: (widget.isActive && widget.colorActive != null)
              ? const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFFF9F218), Color(0xFFE2A246)],
                )
              : null,
          borderRadius: BorderRadius.circular(Dimens.dp20),
        ),
        child: Row(
          textDirection:
              widget.isActive ? TextDirection.rtl : TextDirection.ltr,
          children: [
            thumb(context),
            widget.withText ? text(context) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget text(BuildContext context) {
    final white = context.theme.scaffoldBackgroundColor;
    return Expanded(
      child: SubTitleText(
        widget.isActive ? 'ON' : 'OFF',
        style: TextStyle(color: white, fontSize: Dimens.dp12, height: 0),
        align: TextAlign.center,
      ),
    );
  }

  Widget thumb(BuildContext context) {
    final white = context.theme.scaffoldBackgroundColor;
    return Container(
      width: widget.withText ? Dimens.dp16 : Dimens.dp26,
      height: widget.withText ? Dimens.dp16 : Dimens.dp26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: white,
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor.withValues(alpha: .2),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}
