import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/google_button.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/auth/presentation/views/sign_in_screen.dart';
import 'package:montra_app/src/auth/presentation/widgets/sign_up_widgets/privacy_policy_button.dart';
import 'package:montra_app/src/auth/presentation/widgets/sign_up_widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ValueNotifier<bool> agreePrivacyPolicy = ValueNotifier<bool>(false);

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.langauage.signUp,
          style: context.theme.textTheme.displayLarge!.copyWith(
            color: AppColorsLight.dark50Color,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(height: context.height * 0.06),
          SignUpForm(
            userNameController: userNameController,
            emailController: emailController,
            passwordController: passwordController,
            formKey: formKey,
          ),
          SizedBox(height: context.height * 0.03),
          PrivacyPolicyButton(myBool: agreePrivacyPolicy),
          SizedBox(height: context.height * 0.03),
          ElevatedButton(
            onPressed: () {},
            child: Text(context.langauage.signUp),
          ),
          SizedBox(height: context.height * 0.02),
          Text(
            context.langauage.orWith,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.bodySmall!.copyWith(
              color: AppColorsLight.light20Color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.height * 0.02),
          const GoogleButton(),
          SizedBox(height: context.height * 0.02),
          Text.rich(
            TextSpan(
              text: context.langauage.alreadyHaveAccount,
              style: const TextStyle(
                color: AppColorsLight.light20Color,
              ),
              children: [
                TextSpan(
                  text: ' ${context.langauage.login}',
                  style: const TextStyle(
                    color: AppColorsLight.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushReplacementNamed(
                          context,
                          SignInScreen.routeName,
                        ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
