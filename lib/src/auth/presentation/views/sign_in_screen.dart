import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/widgets/show_loading_dialog.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/core/utils/core_utils.dart';
import 'package:montra_app/src/auth/data/model/user_model.dart';
import 'package:montra_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:montra_app/src/auth/presentation/views/email_verify_screen.dart';
import 'package:montra_app/src/auth/presentation/views/sign_up_screen.dart';
import 'package:montra_app/src/auth/presentation/widgets/sign_in_widgets/sign_in_button.dart';
import 'package:montra_app/src/auth/presentation/widgets/sign_in_widgets/sign_in_form.dart';
import 'package:montra_app/src/dashboard/presentation/views/dashboard.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.langauage.login,
          style: context.theme.textTheme.displayLarge!.copyWith(
            color: AppColorsLight.dark50Color,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (_, state) async {
            if (state is AuthLoading) {
              LoadingDialog.show(context);
            } else if (state is AuthError) {
              LoadingDialog.hide(context);
              CoreUtlis.showSnackBar(context, state.message);
            } else if (state is SignedIn) {
              final navigator = Navigator.of(context);
              context.userProvider.initUser(state.user as LocalUserModel);

              final user = sl<FirebaseAuth>().currentUser!;
              await user.reload();

              if (context.mounted) LoadingDialog.hide(context);

              unawaited(
                user.emailVerified
                    ? navigator.pushReplacementNamed(Dashboard.routeName)
                    : navigator.pushNamed(
                        EmailVerifyScreen.routeName,
                        arguments: emailController.text.trim(),
                      ),
              );
            }
          },
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(height: context.height * 0.07),
              SignInForm(
                emailController: emailController,
                passwordController: passwordController,
                formKey: formKey,
              ),
              SignInButton(
                emailController: emailController,
                passwordController: passwordController,
                formKey: formKey,
              ),
              SizedBox(height: context.height * 0.05),
              TextButton(
                onPressed: () {},
                child: Text(
                  context.langauage.forgotPassword,
                ),
              ),
              SizedBox(height: context.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.langauage.dontHaveAccount,
                    style: const TextStyle(
                      color: AppColorsLight.light20Color,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 3),
                  TextButton(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                          textStyle: const WidgetStatePropertyAll<TextStyle>(
                            TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    onPressed: () {
                      emailController.clear();
                      passwordController.clear();
                      Navigator.pushReplacementNamed(
                        context,
                        SignUpScreen.routeName,
                      );
                    },
                    child: Text(context.langauage.signUp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
