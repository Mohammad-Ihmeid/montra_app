import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/i_field.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/auth/presentation/widgets/sign_in_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.emailController,
            hintText: context.langauage.email,
            hintStyle: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.height * 0.03),
          IField(
            controller: widget.passwordController,
            hintText: context.langauage.password,
            hintStyle: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: context.height * 0.05),
          SignInButton(
            emailController: widget.emailController,
            passwordController: widget.passwordController,
            formKey: widget.formKey,
          ),
          SizedBox(height: context.height * 0.05),
        ],
      ),
    );
  }
}
