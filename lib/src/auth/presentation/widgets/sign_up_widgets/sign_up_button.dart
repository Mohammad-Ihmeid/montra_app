import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/widgets/show_loading_dialog.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/utils/core_utils.dart';
import 'package:montra_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:montra_app/src/auth/presentation/views/sign_in_screen.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.agreePrivacyPolicy,
    super.key,
  });

  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool agreePrivacyPolicy;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingDialog.show(context);
        } else if (state is AuthError) {
          LoadingDialog.hide(context);
          CoreUtlis.showSnackBar(context, state.message);
        } else if (state is SignedUp) {
          LoadingDialog.hide(context);

          Navigator.pushReplacementNamed(context, SignInScreen.routeName);
        }
      },
      builder: (_, __) => ElevatedButton(
        onPressed: () => onPressed(context: context),
        child: Text(context.langauage.signUp),
      ),
    );
  }

  void onPressed({required BuildContext context}) {
    FocusManager.instance.primaryFocus?.unfocus();
    FirebaseAuth.instance.currentUser?.reload();

    if (!formKey.currentState!.validate()) return;
    debugPrint(agreePrivacyPolicy.toString());
    if (!agreePrivacyPolicy) {
      CoreUtlis.showSnackBar(context, context.langauage.acceptPrivacyPolicy);
      return;
    }

    context.read<AuthBloc>().add(
          SignUpEvent(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            name: userNameController.text.trim(),
          ),
        );
  }
}
