import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({
    required this.image,
    required this.description,
    required this.onTap,
    required this.balance,
    super.key,
  });

  final String image;
  final String description;
  final String balance;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColorsLight.indicatorColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Container(
                height: context.height * 0.08,
                width: context.width * 0.14,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFF1F1FA),
                ),
                child: Image.network(image),
              ),
              SizedBox(width: context.width * 0.04),
              Text(
                description,
                style: context.theme.textTheme.headlineMedium!.copyWith(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Text(
                r'$' '$balance',
                style: context.theme.textTheme.headlineMedium!.copyWith(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
