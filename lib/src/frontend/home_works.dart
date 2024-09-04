import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';

class Homework extends StatefulWidget {
  const Homework({super.key});

  @override
  State<Homework> createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 233, 219, 201),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffff6961),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.red.shade300])),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 233, 219, 201),
        child: Column(
          children: [
            ListBody(
              children: [
                Column(
                  children: [
                    MUIPrimaryListTile(
                        title: Container(), description: Container())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
