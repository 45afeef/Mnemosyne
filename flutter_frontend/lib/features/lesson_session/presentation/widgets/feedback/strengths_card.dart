import 'package:flutter/material.dart';

class StrengthsCard extends StatelessWidget {
  const StrengthsCard({super.key, required this.strengths});

  final List<String> strengths;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: strengths
            .map(
              (item) => ListTile(
                leading: const Icon(Icons.check_circle),
                title: Text(item),
              ),
            )
            .toList(),
      ),
    );
  }
}
