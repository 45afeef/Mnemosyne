import 'package:flutter/material.dart';

class FlashcardFront extends StatelessWidget {
  const FlashcardFront({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
