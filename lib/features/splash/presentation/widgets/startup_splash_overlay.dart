import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Pantalla de arranque usada durante el bootstrap real de la aplicación.
class StartupSplashScreen extends StatelessWidget {
  const StartupSplashScreen({
    super.key,
    this.duration = const Duration(milliseconds: 2550),
  });

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _SplashScene(
        primary: theme.colorScheme.primary,
        secondary: theme.colorScheme.secondary,
        background: theme.scaffoldBackgroundColor,
        totalDuration: duration,
        animateOutro: false,
      ),
    );
  }
}

/// Overlay inicial con animación breve de marca antes de mostrar la app.
class StartupSplashOverlay extends StatefulWidget {
  const StartupSplashOverlay({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 2550),
  });

  final Widget child;
  final Duration duration;

  @override
  State<StartupSplashOverlay> createState() => _StartupSplashOverlayState();
}

class _StartupSplashOverlayState extends State<StartupSplashOverlay> {
  Timer? _dismissTimer;
  var _isVisible = true;

  @override
  void initState() {
    super.initState();
    _dismissTimer = Timer(widget.duration, () {
      if (!mounted) {
        return;
      }
      setState(() => _isVisible = false);
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final background = theme.scaffoldBackgroundColor;

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (_isVisible)
          _SplashScene(
            primary: primary,
            secondary: secondary,
            background: background,
            totalDuration: widget.duration,
          ),
      ],
    );
  }
}

class _SplashScene extends StatelessWidget {
  const _SplashScene({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.totalDuration,
    this.animateOutro = true,
  });

  final Color primary;
  final Color secondary;
  final Color background;
  final Duration totalDuration;
  final bool animateOutro;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final outroDelayMs = math.max(1650, totalDuration.inMilliseconds - 520);

    final content = IgnorePointer(
      child: ColoredBox(
        color: background,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primary.withValues(alpha: 0.08),
                    background,
                    secondary.withValues(alpha: 0.06),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -110,
              right: -40,
              child:
                  _GlowBlob(color: primary.withValues(alpha: 0.18), size: 220)
                      .animate()
                      .scale(
                        begin: const Offset(0.85, 0.85),
                        end: const Offset(1, 1),
                        duration: 900.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(duration: 500.ms),
            ),
            Positioned(
              bottom: -70,
              left: -40,
              child:
                  _GlowBlob(color: secondary.withValues(alpha: 0.12), size: 180)
                      .animate()
                      .move(
                        begin: const Offset(-14, 14),
                        end: Offset.zero,
                        duration: 900.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(duration: 600.ms),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _OrbitPainter(
                  strokeColor: primary.withValues(alpha: 0.16),
                  accentColor: secondary.withValues(alpha: 0.12),
                ),
              ).animate().fadeIn(delay: 120.ms, duration: 500.ms),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.62),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: primary.withValues(alpha: 0.12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          child: Text(
                            'Tu espacio wellness offline',
                            style: textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 90.ms, duration: 320.ms)
                      .slideY(begin: -0.35, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 20),
                  _SplashMark(primary: primary)
                      .animate()
                      .fadeIn(delay: 140.ms, duration: 450.ms)
                      .scale(
                        begin: const Offset(0.74, 0.74),
                        end: const Offset(1, 1),
                        duration: 900.ms,
                        curve: Curves.easeOutBack,
                      )
                      .then(delay: 120.ms)
                      .move(
                        begin: const Offset(0, 8),
                        end: Offset.zero,
                        duration: 450.ms,
                        curve: Curves.easeOut,
                      )
                      .shimmer(delay: 650.ms, duration: 900.ms),
                  const SizedBox(height: 24),
                  Text(
                        'Fitora',
                        style: textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 320.ms, duration: 520.ms)
                      .slideY(begin: 0.22, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 12),
                  Container(
                        width: 88,
                        height: 4,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.28),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 240.ms)
                      .scaleX(begin: 0.2, end: 1, curve: Curves.easeOutCubic),
                  const SizedBox(height: 8),
                  Text(
                        'Nutricion, habitos y progreso en un solo lugar',
                        style: textTheme.bodyLarge?.copyWith(
                          color: textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.72,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                      .animate()
                      .fadeIn(delay: 620.ms, duration: 500.ms)
                      .slideY(begin: 0.16, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 18),
                  Text(
                    'Cargando tu panel personal',
                    style: textTheme.bodyMedium?.copyWith(
                      color: textTheme.bodyMedium?.color?.withValues(
                        alpha: 0.54,
                      ),
                    ),
                  ).animate().fadeIn(delay: 820.ms, duration: 380.ms),
                  const SizedBox(height: 24),
                  SizedBox(
                        width: 148,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            backgroundColor: primary.withValues(alpha: 0.16),
                            valueColor: AlwaysStoppedAnimation<Color>(primary),
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(delay: 980.ms, duration: 250.ms)
                      .shimmer(duration: 900.ms),
                ],
              ),
            ),
            Positioned(
              bottom: 36,
              left: 24,
              right: 24,
              child: Text(
                'Analitica, seguimiento y planes listos en segundos',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge?.copyWith(
                  color: textTheme.labelLarge?.color?.withValues(alpha: 0.42),
                  letterSpacing: 0.2,
                ),
              ).animate().fadeIn(delay: 1100.ms, duration: 420.ms),
            ),
          ],
        ),
      ),
    );

    if (!animateOutro) {
      return content;
    }

    return content
        .animate()
        .fadeOut(
          delay: Duration(milliseconds: outroDelayMs),
          duration: 360.ms,
        )
        .scale(
          delay: Duration(milliseconds: outroDelayMs),
          begin: const Offset(1, 1),
          end: const Offset(1.02, 1.02),
          duration: 360.ms,
          curve: Curves.easeInOut,
        );
  }
}

class _SplashMark extends StatelessWidget {
  const _SplashMark({required this.primary});

  final Color primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 142,
      height: 142,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.92),
                  primary.withValues(alpha: 0.94),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: 0.22),
                  blurRadius: 32,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: const SizedBox.expand(),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Image.asset(
              'assets/branding/fitora_app_icon_1024.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox(width: size, height: size),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  const _OrbitPainter({required this.strokeColor, required this.accentColor});

  final Color strokeColor;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = strokeColor;
    final accentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = accentColor;

    canvas.drawOval(
      Rect.fromCenter(center: center, width: size.width * 0.72, height: 240),
      orbitPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: center, width: size.width * 0.86, height: 340),
      accentPaint,
    );

    final dotPaint = Paint()..color = strokeColor.withValues(alpha: 0.7);
    final radius = math.min(size.width, size.height) * 0.28;
    canvas.drawCircle(center.translate(radius, -18), 5, dotPaint);
    canvas.drawCircle(center.translate(-radius * 0.9, 38), 3.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.accentColor != accentColor;
  }
}
