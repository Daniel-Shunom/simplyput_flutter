import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        backgroundColor: Colors.transparent,
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
      body: Center(
        child: Column(
          children: [
            ListBody(
              children: [
                MUIPrimaryListTile(title: Container(), description: Container())
              ],
            )
          ],
        ),
      ),
    );
  }
}
