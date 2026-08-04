import 'package:flutter/material.dart';

import '../../../domain/entities/mcq.dart';

class McqOptionTile extends StatelessWidget {
  const McqOptionTile({super.key, required this.option});

  final McqOption option;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(option.text), onTap: () {});
  }
}
