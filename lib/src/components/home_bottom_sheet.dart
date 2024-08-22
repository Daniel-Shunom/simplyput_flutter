import 'package:flutter/material.dart';

class HomeUploadSheet extends StatelessWidget {
  const HomeUploadSheet({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: HUSheet(),
    );
  }
}

class HUSheet extends StatelessWidget {
  const HUSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        height: 400,
        child: Center(
          child: ElevatedButton(
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }
}
