import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/core/utils/core_utils.dart';
import 'package:montra_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:montra_app/src/home/presentation/views/home_screen.dart';
import 'package:provider/provider.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen(this.email, {super.key});

  static const routeName = '/email-verification';
  final String email;

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const SendEmailVerifyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.langauage.verification,
          style: context.theme.textTheme.displayLarge!.copyWith(
            color: AppColorsLight.dark50Color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Image.asset(MediaRes.emailVerify)),
            SizedBox(height: context.height * 0.03),
            Text(
              context.langauage.verifyYourEmailAddress,
              style: const TextStyle(
                color: AppColorsLight.darkColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: context.height * 0.03),
            Text(
              widget.email,
              style: const TextStyle(
                color: AppColorsLight.darkColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: context.height * 0.03),
            Text(
              context.langauage.accountAwaits,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColorsLight.darkColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: context.height * 0.03),
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                if (await onPressedContinue()) {
                  unawaited(
                    navigator.pushReplacementNamed(HomeScreen.routeName),
                  );
                } else {
                  if (context.mounted) {
                    CoreUtlis.showSnackBar(
                      context,
                      context.langauage.checkYourInbox,
                    );
                  }
                }
              },
              child: Text(context.langauage.continues),
            ),
            SizedBox(height: context.height * 0.03),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const SendEmailVerifyEvent());
                CoreUtlis.showSnackBar(context, '');
              },
              child: Text(
                context.langauage.didntReceivedCode,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: context.height * 0.06),
          ],
        ),
      ),
    );
  }

  Future<bool> onPressedContinue() async {
    final user = sl<FirebaseAuth>().currentUser!;

    await user.reload();

    return user.emailVerified;
    // unawaited(
    //  if(user.emailVerified)
    //       ? navigator.pushReplacementNamed(HomeScreen.routeName)
    //       : CoreUtlis.showSnackBar(context, ''),
    // );
  }
}
