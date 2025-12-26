import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core.dart';

class ItemDropdownMenu {
  final String icon;
  final String label;

  ItemDropdownMenu({required this.icon, required this.label});
}

class DropdownMenuButton extends StatelessWidget {
  const DropdownMenuButton({
    super.key,
    required this.onChanged,
    required this.menus,
    required this.child,
  });
  final ValueChanged<dynamic> onChanged;
  final List<ItemDropdownMenu> menus;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: menus
            .map((e) => menuItem(context, label: e.label, icon: e.icon))
            .toList(),
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.dp8),
          ),
        ),
        customButton: child,
      ),
    );
  }

  DropdownMenuItem<dynamic> menuItem(
    BuildContext context, {
    required String label,
    required String icon,
  }) {
    return DropdownMenuItem(
      value: label,
      child: Row(
        spacing: Dimens.dp12,
        children: [
          SvgPicture.asset(icon, height: Dimens.dp16),
          RegularText.medium(
            context,
            label,
            style: const TextStyle(fontSize: Dimens.dp12),
          ),
        ],
      ),
    );
  }
}
