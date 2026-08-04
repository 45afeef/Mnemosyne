import 'package:flutter/material.dart';

class FlashcardBack extends StatelessWidget {
  const FlashcardBack({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
