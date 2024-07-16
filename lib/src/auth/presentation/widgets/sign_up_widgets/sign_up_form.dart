import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/i_field.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.userNameController,
            hintText: context.langauage.name,
            hintStyle: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.height * 0.03),
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
        ],
      ),
    );
  }
}
