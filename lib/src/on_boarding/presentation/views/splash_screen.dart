import 'dart:async';

import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:montra_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    final prefs = sl<SharedPreferences>();

    if (prefs.getBool(kFirstTimerKey) ?? true) {
      Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.primaryColor,
      body: Center(
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
          ],
        ),
      ),
    );
  }
}
