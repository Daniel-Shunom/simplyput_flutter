import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:modular_ui/modular_ui.dart';

class RecognizePage extends StatefulWidget {
  final String? imgpath;
  final String? docpath;
  const RecognizePage({super.key, this.imgpath, this.docpath});

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
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffff6961),
                    spreadRadius: 1,
                    blurRadius: 4,
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(
                    colors: [Colors.orange.shade400, Colors.red.shade300])),
          ),
        ),
      ),
      body: _isBusy == true
          ? const SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 6, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffff6961),
                            spreadRadius: 1,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        maxLines: 15,
                        controller: _ocrController,
                        decoration: const InputDecoration(
                          hintText: "Text goes at this spot",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  //ACTION BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MUIPrimaryButton(
                                text: "summarize", onPressed: () {}),
                            const SizedBox(
                              width: 10,
                            ),
                            MUIPrimaryButton(
                                text: "summarize", onPressed: () {}),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
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
