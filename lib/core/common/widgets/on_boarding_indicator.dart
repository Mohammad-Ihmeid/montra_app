import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class OnBoardingIndicator extends StatelessWidget {
  const OnBoardingIndicator({required this.isSelect, super.key});

  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isSelect ? 20 : 10,
      height: isSelect ? 20 : 10,
      margin: EdgeInsets.only(right: context.width * 0.04),
      decoration: BoxDecoration(
        color: isSelect
            ? AppColorsLight.primaryColor
            : AppColorsLight.indicatorColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
