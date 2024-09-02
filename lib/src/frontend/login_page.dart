import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginEmailController = TextEditingController();

  final loginPasswordController = TextEditingController();

  //sign user in
  void signUserIn() async {
    //show dialog circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.purple.shade100,
            ),
          );
        });

    //wrong email message popup
    void wrongEmailMessage() {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Wrong email :("),
            );
          });
    }

    //wrong password message popup
    void wrongPasswordMessage() {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Wrong password pal :("),
            );
          });
    }

    //try login
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text);
      //pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //wrong email
      if (e.code == "user-not-found") {
        //show error to user
        wrongEmailMessage();
        print('No user found for that email');
      }

      //wrong password
      else if (e.code == "wrong-password") {
        //wrong password message
        wrongPasswordMessage();
        print("Wrong password pal");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.orange.shade200,
          Colors.red.shade200,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: MUISignInCard(
            emailController: loginEmailController,
            passwordController: loginPasswordController,
            onSignInPressed: () async {
              signUserIn();
            },
            onRegisterNow: () {},
          ),
        ),
      ),
    ));
  }
}
