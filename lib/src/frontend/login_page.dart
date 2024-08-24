import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:simplyputapp/src/frontend/signup_page.dart';

class LoginPage extends StatelessWidget {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  LoginPage({
    super.key,
  });

  //sign user in
  void signUserIn() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: MUISignInCard(
          emailController: loginEmailController,
          passwordController: loginPasswordController,
          onSignInPressed: () async {
            signUserIn;
          },
          onRegisterNow: () {},
        ),
      ),
    ));
  }
}
