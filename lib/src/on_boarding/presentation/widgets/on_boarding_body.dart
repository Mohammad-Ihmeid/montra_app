import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/on_boarding_indicator.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/on_boarding/domain/entities/page_content.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    required this.pageContent,
    required this.currentIndex,
    super.key,
  });

  final PageContent pageContent;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: context.height * 0.06),
        Expanded(child: Image.asset(pageContent.image)),
        SizedBox(height: context.height * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            pageContent.title,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: context.height * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            pageContent.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: context.height * 0.05),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnBoardingIndicator(isSelect: currentIndex == 0),
            OnBoardingIndicator(isSelect: currentIndex == 1),
            OnBoardingIndicator(isSelect: currentIndex == 2),
          ],
        ),
        SizedBox(height: context.height * 0.03),
      ],
    );
  }
}
