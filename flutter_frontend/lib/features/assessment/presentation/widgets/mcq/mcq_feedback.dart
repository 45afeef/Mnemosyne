import 'package:flutter/material.dart';

class McqFeedback extends StatelessWidget {
  const McqFeedback({super.key, required this.isCorrect, this.explanation});

  final bool isCorrect;

  final String? explanation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(isCorrect ? 'Correct' : 'Incorrect'),

        if (explanation != null) Text(explanation!),
      ],
    );
  }
}
