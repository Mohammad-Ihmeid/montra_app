import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.lightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColorsLight.light60Color),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MediaRes.googleIcon,
            width: context.width * 0.07,
            height: context.height * 0.05,
          ),
          const SizedBox(width: 5),
          Text(
            context.langauage.signUpWithGoogle,
            style: context.theme.textTheme.displayLarge!.copyWith(
              color: AppColorsLight.dark50Color,
            ),
          ),
        ],
      ),
    );
  }
}
