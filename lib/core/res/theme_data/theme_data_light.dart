import 'package:flutter/material.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/fonts.dart';

ThemeData themeDataLight() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: AppColorsLight.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Fonts.inter,
    scaffoldBackgroundColor: AppColorsLight.lightColor,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      centerTitle: true,
    ),
    textTheme: textTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColorsLight.primaryColor,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
      ),
    ),
    indicatorColor: AppColorsLight.primaryColor,
    checkboxTheme: const CheckboxThemeData(
      visualDensity: VisualDensity(
        vertical: VisualDensity.minimumDensity,
        horizontal: VisualDensity.minimumDensity,
      ),
      side: BorderSide(color: AppColorsLight.primaryColor, width: 2),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        highlightColor: Colors.transparent,
      ),
    ),
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
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
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
    /* Body 3 */
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );
}
