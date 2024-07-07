import 'package:flutter/material.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColorsLight.lightColor,
          ),
        ),
      ),
    );
  }
}
