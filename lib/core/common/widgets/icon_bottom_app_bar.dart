import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class IconBottomAppBar extends StatelessWidget {
  const IconBottomAppBar({
    required this.selectedIcon,
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  final bool selectedIcon;
  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: context.width * 0.10,
            color: selectedIcon
                ? AppColorsLight.primaryColor
                : AppColorsLight.iconColor,
          ),
          Text(
            label,
            style: TextStyle(
              color: selectedIcon
                  ? AppColorsLight.primaryColor
                  : AppColorsLight.iconColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
