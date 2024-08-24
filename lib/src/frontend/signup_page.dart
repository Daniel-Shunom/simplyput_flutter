import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:simplyputapp/src/frontend/login_page.dart';

class SignupPage extends StatelessWidget {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MUISignUpCard(
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          onSignUpPressed: () async {},
          onLogInNowPressed: () async {},
        ),
      ),
    );
  }
}
