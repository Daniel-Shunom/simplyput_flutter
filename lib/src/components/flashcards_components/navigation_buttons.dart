import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'flashcard_provider.dart';

class NavigationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: provider.prevCard,
              child: Text('Previous'),
            ),
            ElevatedButton(
              onPressed: provider.nextCard,
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }
}
