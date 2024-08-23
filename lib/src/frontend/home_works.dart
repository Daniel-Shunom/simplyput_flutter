import 'package:flutter/material.dart';

class Homework extends StatefulWidget {
  const Homework({super.key});

  @override
  State<Homework> createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Homeworks"),
      ),
    );
  }
}
