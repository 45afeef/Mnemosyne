import 'package:flutter/material.dart';

class TopicProgressIndicator extends StatelessWidget {
  const TopicProgressIndicator({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;

  final int total;

  @override
  Widget build(BuildContext context) {
    return Text('$current / $total');
  }
}
