import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("profile"),
        backgroundColor: Colors.grey.shade900,
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 50,
          ),

          //profile pic
          Icon(Icons.person, size: 72)

          //user email

          // username

          // user bio
        ],
      ),
    );
  }
}
