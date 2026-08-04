import 'package:flutter/material.dart';

class AssessmentHeader extends StatelessWidget {
  const AssessmentHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16), child: Text(title));
  }
}
