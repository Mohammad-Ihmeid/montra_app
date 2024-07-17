import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    required this.image,
    required this.label,
    required this.onTap,
    this.color,
    this.iconColor,
    this.borderColor,
    super.key,
  });

  final Color? color;
  final Color? iconColor;
  final Color? borderColor;
  final String image;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: borderColor ?? Colors.white)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color,
              ),
              child: Image.asset(
                image,
                width: context.width * 0.06,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColorsLight.dark25Color,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
