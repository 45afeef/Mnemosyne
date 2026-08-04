import 'package:flutter/material.dart';

class SessionProgressBar extends StatelessWidget {
  const SessionProgressBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: progress);
  }
}
