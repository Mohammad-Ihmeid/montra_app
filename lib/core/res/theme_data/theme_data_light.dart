import 'package:flutter/material.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/fonts.dart';

ThemeData themeDataLight() {
  return ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Fonts.inter,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    colorScheme:
        ColorScheme.fromSwatch(accentColor: AppColorsLight.primaryColor),
  );
}
