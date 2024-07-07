import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/auth/presentation/views/sign_in_screen.dart';
import 'package:montra_app/src/auth/presentation/views/sign_up_screen.dart';
import 'package:montra_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:montra_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:montra_app/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/on-boarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    OnBoardingBody(
                      pageContent: PageContent(
                        image: MediaRes.controlYourMoney,
                        title: context.langauage.onBoardingTitle('first'),
                        description: context.langauage.onBoardingDesc('first'),
                      ),
                      currentIndex: 0,
                    ),
                    OnBoardingBody(
                      pageContent: PageContent(
                        image: MediaRes.whereYourMoney,
                        title: context.langauage.onBoardingTitle('second'),
                        description: context.langauage.onBoardingDesc('second'),
                      ),
                      currentIndex: 1,
                    ),
                    OnBoardingBody(
                      pageContent: PageContent(
                        image: MediaRes.planningAhead,
                        title: context.langauage.onBoardingTitle('third'),
                        description: context.langauage.onBoardingDesc('third'),
                      ),
                      currentIndex: 2,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                  Navigator.pushReplacementNamed(
                    context,
                    SignUpScreen.routeName,
                  );
                },
                child: Text(
                  context.langauage.signUp,
                  style: context.theme.textTheme.displayLarge,
                ),
              ),
              SizedBox(height: context.height * 0.03),
              ElevatedButton(
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                  Navigator.pushReplacementNamed(
                    context,
                    SignInScreen.routeName,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsLight.indicatorColor,
                ),
                child: Text(
                  context.langauage.login,
                  style: context.theme.textTheme.displayLarge!.copyWith(
                    color: AppColorsLight.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
