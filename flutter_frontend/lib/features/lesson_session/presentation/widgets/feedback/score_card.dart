import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    return Card(child: Center(child: Text('${(score * 100).round()}%')));
  }
}
