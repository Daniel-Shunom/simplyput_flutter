import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const Home());
}

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
      backgroundColor: const Color.fromARGB(255, 179, 203, 255),
      appBar: AppBar(
        title: const Text('S I M P L Y  P U T'),
        backgroundColor: Colors.amber.shade100,
      ),
      drawer: const Drawer(),
      drawerEnableOpenDragGesture: true,
      body: Container(
        color: Color.fromARGB(255, 15, 31, 65),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          //BUTTONS
          child: Column(
            //MODIFY THE BUTOTNS HERE!!
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //ANIMATED SVG
              Expanded(
                  child: ListView(children: [
                Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Color(0xffffb347),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xffff6961),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(2, 2))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 80,
                        height: 60,
                        child: LottieBuilder.asset(
                            "assets/app_assets/upload.json"),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {},
                          child: Text("upload documents")),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color(0xffffb347),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffff6961),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(2, 2))
                        ])),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color(0xffffb347),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffff6961),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(2, 2))
                        ])),
                const SizedBox(height: 20),
              ])),

              //Button Container
              /*Container(
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
              const SizedBox(height: 20)*/
            ],
          ),
        ),
      ),
    );
  }
}
