import 'package:flutter/material.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/fonts.dart';

ThemeData themeDataLight() {
  return ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Fonts.inter,
    scaffoldBackgroundColor: AppColorsLight.lightColor,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    textTheme: textTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    colorScheme:
        ColorScheme.fromSwatch(accentColor: AppColorsLight.primaryColor),
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsLight.primaryColor,
      foregroundColor: AppColorsLight.light80Color,
      minimumSize: const Size(double.maxFinite, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    /* Title 1 */
    headlineMedium: TextStyle(
      color: AppColorsLight.dark50Color,
      fontSize: 35,
      fontWeight: FontWeight.bold,
    ),
    /* Title 3 */
    displayLarge: TextStyle(
      color: AppColorsLight.light80Color,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}
