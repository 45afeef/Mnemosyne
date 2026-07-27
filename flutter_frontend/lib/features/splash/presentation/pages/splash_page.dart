import 'package:flutter/material.dart';

import '../widgets/splash_background.dart';
import '../widgets/splash_content.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SplashBackground(),
          SafeArea(
            child: Center(
              child: SplashContent(),
            ),
          ),
        ],
      ),
    );
  }
}