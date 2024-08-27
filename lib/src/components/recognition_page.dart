import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizePage extends StatefulWidget {
  final String? imgpath;
  const RecognizePage({super.key, this.imgpath});

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  final TextEditingController _ocrController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final InputImage inputImageFile = InputImage.fromFilePath(widget.imgpath!);

    processImage(inputImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recognized page"),
      ),
      body: _isBusy == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _ocrController,
                decoration:
                    const InputDecoration(hintText: "Text goes at this spot"),
              ),
            ),
    );
  }

  void processImage(InputImage image) {
    setState(() {
      _isBusy = true;
    });

    print(image.filePath!);

    //end the busy state
    setState(() {
      _isBusy = false;
    });
  }
}
