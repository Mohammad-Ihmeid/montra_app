import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/show_loading_dialog.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/auth/presentation/views/sign_in_screen.dart';

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${context.langauage.logout}?',
            style: context.theme.textTheme.displayLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            context.langauage.youSureLogout,
            style: context.theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorsLight.indicatorColor,
                  ),
                  child: Text(
                    context.langauage.no,
                    style: context.theme.textTheme.displayLarge!.copyWith(
                      color: AppColorsLight.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    LoadingDialog.show(context);
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) LoadingDialog.hide(context);
                    unawaited(
                      navigator.pushNamedAndRemoveUntil(
                        SignInScreen.routeName,
                        (route) => false,
                      ),
                    );
                  },
                  child: Text(context.langauage.yes),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
