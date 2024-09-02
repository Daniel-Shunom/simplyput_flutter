import 'package:flutter/material.dart';

class OcrListPage extends StatefulWidget {
  final TextEditingController ocrController;

  const OcrListPage({super.key, required this.ocrController});

  @override
  _OcrListPageState createState() => _OcrListPageState();
}

class _OcrListPageState extends State<OcrListPage> {
  List<String> ocrTexts = [];

  @override
  void initState() {
    super.initState();
    // Add listener to the ocrController
    widget.ocrController.addListener(_onOcrTextChanged);
  }

  @override
  void dispose() {
    widget.ocrController.removeListener(_onOcrTextChanged);
    super.dispose();
  }

  void _onOcrTextChanged() {
    if (widget.ocrController.text.isNotEmpty) {
      setState(() {
        ocrTexts.add(widget.ocrController.text);
      });
      // Clear the controller
      widget.ocrController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR Text List'),
      ),
      body: ListView.builder(
        itemCount: ocrTexts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ocrTexts[index]),
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
          );
        },
      ),
    );
  }
}
