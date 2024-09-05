import 'package:flutter/material.dart';

void main() {
  runApp(const hwTabBar());
}

class hwTabBar extends StatelessWidget {
  const hwTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AppBar(
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
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.red.shade300],
            ),
          ),
        ),
        bottom: const TabBar(
            tabs: [Text("Summaries"), Text("files"), Text("flashcards")]),
      ),
    );
  }
}
