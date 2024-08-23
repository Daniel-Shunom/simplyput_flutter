import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modular_ui/modular_ui.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MUISignUpCard(
        emailController: emailController, 
        passwordController: passwordController, 
        confirmPasswordController: confirmPasswordController, 
        onSignUpPressed: onSignUpPressed, 
        onLogInNowPressed: (){
          navigator.popAndPushNamed(routeName)
        }
      ),  
    );
  }
}