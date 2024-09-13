import 'package:flutter/material.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:simplyputapp/src/components/homeworkDynamicList.dart';

class Homework extends StatefulWidget {
  const Homework({super.key});

  @override
  State<Homework> createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  Future<List<String>> getPineConeItems() async {
    return await pineConeClient.listIndexes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 233, 219, 201),
        child: FutureBuilder<List<String>>(
          future: getPineConeItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<String> pineConeItems = snapshot.data!;
              return Column(
                children: [
                  ListBody(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          IndexHWItems(items: pineConeItems),
                        ],
                      ),
                    ],
                  )
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
