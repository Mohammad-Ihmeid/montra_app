import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.langauage.repeat,
                style: context.theme.textTheme.bodyLarge!.copyWith(
                  color: AppColorsLight.dark25Color,
                ),
              ),
              Text(
                '${context.langauage.repeat} '
                '${context.langauage.transaction}',
                style: const TextStyle(
                  color: AppColorsLight.light20Color,
                ),
              ),
            ],
          ),
          Switch(
            value: true,
            onChanged: (value) {},
            inactiveTrackColor: AppColorsLight.indicatorColor,
            activeTrackColor: AppColorsLight.primaryColor,
          ),
        ],
      ),
    );
  }
}
