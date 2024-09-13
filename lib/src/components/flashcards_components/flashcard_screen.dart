import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'flashcard_provider.dart';
import 'input_section.dart';
import 'flashcard_display.dart';
import 'navigation_buttons.dart';

class FlashcardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Flashcard Generator'),
      ),
      body: Consumer<FlashcardProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              InputSection(),
              SizedBox(height: 16),
              if (provider.flashcards.isNotEmpty) ...[
                FlashcardDisplay(),
                SizedBox(height: 16),
                NavigationButtons(),
              ],
            ],
          );
        },
      ),
    );
  }
}
