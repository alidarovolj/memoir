import 'dart:math';
import 'package:flutter/material.dart';

/// Particle effect for pet celebrations
class PetParticleEffect extends StatefulWidget {
  final Widget child;
  final bool isActive;
  final Color particleColor;

  const PetParticleEffect({
    super.key,
    required this.child,
    this.isActive = false,
    this.particleColor = Colors.amber,
  });

  @override
  State<PetParticleEffect> createState() => _PetParticleEffectState();
}

class _PetParticleEffectState extends State<PetParticleEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Generate particles
    for (int i = 0; i < 20; i++) {
      _particles.add(
        Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: _random.nextDouble() * 6 + 2,
          speed: _random.nextDouble() * 0.5 + 0.3,
          angle: _random.nextDouble() * 2 * pi,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  particles: _particles,
                  animation: _controller.value,
                  color: widget.particleColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double angle;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.angle,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;
  final Color color;

  ParticlePainter({
    required this.particles,
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    for (var particle in particles) {
      // Calculate position
      final progress = (animation + particle.speed) % 1.0;
      final x = particle.x * size.width + cos(particle.angle) * progress * 50;
      final y = particle.y * size.height - progress * size.height;

      // Fade out
      final opacity = 1.0 - progress;
      paint.color = color.withOpacity(opacity * 0.6);

      // Draw particle
      canvas.drawCircle(Offset(x, y), particle.size, paint);

      // Draw sparkle cross
      if (particle.size > 4) {
        paint.strokeWidth = 1;
        paint.style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(x - particle.size, y),
          Offset(x + particle.size, y),
          paint,
        );
        canvas.drawLine(
          Offset(x, y - particle.size),
          Offset(x, y + particle.size),
          paint,
        );
        paint.style = PaintingStyle.fill;
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) =>
      animation != oldDelegate.animation;
}
