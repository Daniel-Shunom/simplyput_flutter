import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flashcard_provider.dart';

class InputSection extends StatefulWidget {
  @override
  _InputSectionState createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Paste AI response here...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final provider =
                Provider.of<FlashcardProvider>(context, listen: false);
            provider.generateFlashcards(_controller.text);
          },
          child: Text('Generate Flashcards'),
        ),
      ],
    );
  }
}
