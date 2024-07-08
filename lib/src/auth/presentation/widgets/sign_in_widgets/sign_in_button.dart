import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/src/auth/presentation/bloc/auth_bloc.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator();
        } else {
          return ElevatedButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              FirebaseAuth.instance.currentUser?.reload();
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                      SignInEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
              }
            },
            child: Text(context.langauage.login),
          );
        }
      },
    );
  }
}
