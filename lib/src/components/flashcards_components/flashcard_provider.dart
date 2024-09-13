import 'package:flutter/foundation.dart';

class FlashcardProvider with ChangeNotifier {
  List<Map<String, String>> _flashcards = [];
  int _currentCardIndex = 0;

  List<Map<String, String>> get flashcards => _flashcards;
  int get currentCardIndex => _currentCardIndex;

  void generateFlashcards(String text) {
    final cards = text.split('\n\n');
    _flashcards = cards.map((card) {
      final parts = card.split('\n');
      return {
        'question': parts[0],
        'answer': parts.length > 1 ? parts[1] : '',
      };
    }).toList();
    _currentCardIndex = 0;
    notifyListeners();
  }

  void nextCard() {
    if (_flashcards.isNotEmpty) {
      _currentCardIndex = (_currentCardIndex + 1) % _flashcards.length;
      notifyListeners();
    }
  }

  void prevCard() {
    if (_flashcards.isNotEmpty) {
      _currentCardIndex =
          (_currentCardIndex - 1 + _flashcards.length) % _flashcards.length;
      notifyListeners();
    }
  }
}
