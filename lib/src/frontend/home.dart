import 'dart:ffi';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimplyPut',
      theme: ThemeData(
        primaryColor: Colors.amber.shade100,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        title: const Text('S I M P L Y  P U T'),
        backgroundColor: Colors.amber.shade100,
      ),
      drawer: const Drawer(),
      drawerEnableOpenDragGesture: true,
      body: Container(
        color: Colors.amber.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          //BUTTONS
          child: Column(
            //MODIFY THE BUTOTNS HERE!!
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //INNER BUTTON CONTENTS
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 70,
                decoration: BoxDecoration(
                    color: Color(0xffffb347),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffff6961),
                        spreadRadius: 1,
                        blurRadius: 8,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: const Text("data"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: const Text("Upload"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: const Text("data"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
