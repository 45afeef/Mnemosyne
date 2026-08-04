import 'package:flutter/material.dart';

class TopicTransition extends StatelessWidget {
  const TopicTransition({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}
