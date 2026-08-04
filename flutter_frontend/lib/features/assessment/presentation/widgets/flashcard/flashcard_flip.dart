import 'package:flutter/material.dart';

import 'flashcard_back.dart';
import 'flashcard_front.dart';

class FlashcardFlip extends StatefulWidget {
  const FlashcardFlip({super.key, required this.front, required this.back});

  final String front;

  final String back;

  @override
  State<FlashcardFlip> createState() => _FlashcardFlipState();
}

class _FlashcardFlipState extends State<FlashcardFlip> {
  bool _showBack = false;

  void _flip() {
    setState(() {
      _showBack = !_showBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return RotationTransition(turns: animation, child: child);
        },
        child: _showBack
            ? FlashcardBack(key: const ValueKey('back'), text: widget.back)
            : FlashcardFront(key: const ValueKey('front'), text: widget.front),
      ),
    );
  }
}
