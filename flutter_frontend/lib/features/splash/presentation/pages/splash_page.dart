import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mnemosyne_learn/app/router/routes.dart';

import '../widgets/splash_background.dart';
import '../widgets/splash_content.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      context.pushReplacement(Routes.onboarding);
    });

    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SplashBackground(),
          SafeArea(child: Center(child: SplashContent())),
        ],
      ),
    );
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = true; // Replace with your auth logic

    if (!mounted) return;

    context.push(Routes.home);
  }
}
