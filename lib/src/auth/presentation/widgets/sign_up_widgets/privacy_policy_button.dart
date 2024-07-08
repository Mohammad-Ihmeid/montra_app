import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class PrivacyPolicyButton extends StatelessWidget {
  const PrivacyPolicyButton({required this.myBool, super.key});

  final ValueNotifier<bool> myBool;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: myBool,
          builder: (_, value, __) {
            return Checkbox(
              value: value,
              onChanged: (value) {
                myBool.value = !myBool.value;
              },
              activeColor: AppColorsLight.primaryColor,
            );
          },
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: context.langauage.bySigningUpYouAgree,
              style: context.theme.textTheme.bodySmall,
              children: [
                TextSpan(
                  text: ' ${context.langauage.termsAndPrivacy}',
                  style: context.theme.textTheme.bodySmall!.copyWith(
                    color: AppColorsLight.primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
