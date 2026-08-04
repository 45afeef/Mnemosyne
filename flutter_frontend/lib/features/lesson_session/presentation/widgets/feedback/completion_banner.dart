import 'package:flutter/material.dart';

class CompletionBanner extends StatelessWidget {
  const CompletionBanner({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(title), Text(message)]);
  }
}
