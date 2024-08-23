import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MUISignInCard(
            emailController: emailController,
            passwordController: passwordController,
            onSignInPressed: () {},
            onRegisterNow: () {}));
  }
}
