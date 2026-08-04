import 'package:flutter/material.dart';

import 'session_bottom_bar.dart';
import 'step_host.dart';

class SessionScaffold extends StatelessWidget {
  const SessionScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: const StepHost()),
      bottomNavigationBar: const SessionBottomBar(),
    );
  }
}
