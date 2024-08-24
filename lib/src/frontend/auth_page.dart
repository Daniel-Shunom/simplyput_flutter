import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simplyputapp/src/frontend/home.dart';
import 'package:simplyputapp/src/frontend/login_page.dart';
import 'package:simplyputapp/src/frontend/navigation_menu.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return NavigationMenu();
            }

            //User is not logged in
            else {
              return LoginPage();
            }
          }),
    );
  }
}
