import 'package:flutter/material.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static bool _isDialogShowing = false;

  static void show(BuildContext context) {
    if (!_isDialogShowing) {
      _isDialogShowing = true;
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialog(),
      );
    }
  }

  static void hide(BuildContext context) {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Opacity(
        opacity: 0.5,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColorsLight.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
