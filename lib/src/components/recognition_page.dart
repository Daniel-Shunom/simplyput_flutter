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
        toolbarHeight: 50,
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
      body: _isBusy == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                maxLines: MediaQuery.of(context).size.height.toInt(),
                controller: _ocrController,
                decoration:
                    const InputDecoration(hintText: "Text goes at this spot"),
              ),
            ),
    );
  }

  // Google OCR function works here
  void processImage(InputImage image) async {
    final imgTextRecognizer =
        TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText imgRecognizedText =
        await imgTextRecognizer.processImage(image);

    _ocrController.text = imgRecognizedText.text;
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
