import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension StaggerAnimation on Widget {
  Widget stagger(int index) {
    return animate(delay: Duration(milliseconds: index * 850))
        .fadeIn(duration: 600.ms)
        .slideY(begin: .15, curve: Curves.easeOutExpo)
        .slideX(begin: -.05, curve: Curves.easeOutExpo)
        .scale(begin: const Offset(.92, .92));
  }
}
