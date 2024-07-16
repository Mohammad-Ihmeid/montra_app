import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/src/auth/data/model/user_model.dart';
import 'package:montra_app/src/auth/presentation/views/sign_in_screen.dart';
import 'package:montra_app/src/home/presentation/views/home_screen.dart';
import 'package:montra_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:montra_app/src/on_boarding/presentation/views/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _goPage() {
    final user = sl<FirebaseAuth>().currentUser;
    if (user != null) {
      final user = sl<FirebaseAuth>().currentUser!;
      final localUser = LocalUserModel(
        uid: user.uid,
        email: user.email ?? '',
        userName: user.displayName ?? '',
      );
      context.userProvider.initUser(localUser);

      Navigator.pushReplacementNamed(
        context,
        user.emailVerified ? HomeScreen.routeName : SignInScreen.routeName,
      );
    } else {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.primaryColor,
      body: BlocListener<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {
          if (state is OnBoardingStatus && !state.isFirstTimer) {
            Timer(const Duration(seconds: 3), _goPage);
          } else if (state is OnBoardingStatus && state.isFirstTimer) {
            Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacementNamed(
                context,
                OnBoardingScreen.routeName,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 74,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 32,
                      spreadRadius: 5,
                      color: AppColorsLight.pinkColor,
                    ),
                  ],
                ),
              ),
              Text(
                context.langauage.appName,
                style: TextStyle(
                  color: AppColorsLight.lightColor,
                  fontSize: context.width * 0.15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColorsLight.lightColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
