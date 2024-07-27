import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class AddTransactionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AddTransactionAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: context.theme.textTheme.displayLarge,
      ),
      iconTheme: const IconThemeData(
        color: AppColorsLight.lightColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
