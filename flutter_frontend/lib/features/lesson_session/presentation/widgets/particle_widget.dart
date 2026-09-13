import 'dart:math';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final Random _random = Random();
  final List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _controller.addListener(_updateParticles);
  }

  void _updateParticles() {
    final size = context.size;

    if (size == null) return;

    if (_particles.length < 40) {
      _particles.add(
        _Particle(
          x: _random.nextDouble() * size.width,
          y: size.height + 10,
          size: _random.nextDouble() * 3 + 1,
          speedY: _random.nextDouble() * -1.5 - 0.5,
          speedX: _random.nextDouble() * 0.5 - 0.25,
          opacity: _random.nextDouble() * 0.5 + 0.2,
          color: [
            AppColors.primary,
            AppColors.secondary,
            AppColors.tertiary,
            AppColors.primaryContainer,
            AppColors.surface,
          ][Random().nextInt(5)],
        ),
      );
    }

    for (int i = _particles.length - 1; i >= 0; i--) {
      final particle = _particles[i];

      particle
        ..y += particle.speedY
        ..x += particle.speedX;

      if (particle.opacity > 0.01) {
        particle.opacity -= 0.002;
      }

      if (particle.opacity <= 0.01 || particle.y < -10) {
        _particles.removeAt(i);
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateParticles);
    _controller.stop();
    _controller.dispose();

    _particles.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _ParticlePainter(particles: _particles, repaint: _controller),
        size: Size.infinite,
      ),
    );
  }
}

class _Particle {
  double x;
  double y;
  final double size;
  final double speedY;
  final double speedX;
  double opacity;
  final Color color;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedY,
    required this.speedX,
    required this.opacity,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter({required this.particles, super.repaint});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color.withValues(
          alpha: particle.opacity.clamp(0.0, 1.0),
        );

      canvas.drawCircle(Offset(particle.x, particle.y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return false;
  }
}
