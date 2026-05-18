import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'theme_style.dart';

class AnimatedThemeScene extends StatefulWidget {
  final String theme;
  final double height;

  const AnimatedThemeScene({
    super.key,
    required this.theme,
    this.height = 190,
  });

  @override
  State<AnimatedThemeScene> createState() => _AnimatedThemeSceneState();
}

class _AnimatedThemeSceneState extends State<AnimatedThemeScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = styleForTheme(widget.theme);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: widget.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [style.primary, style.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BubblePainter(style.accent),
                  ),
                ),
                ...List.generate(style.sprites.length, (index) {
                  return _FlyingSprite(
                    controller: _controller,
                    text: style.sprites[index],
                    index: index,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  );
                }),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(45),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white.withAlpha(85)),
                        ),
                        child: Text(
                          style.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        style.subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FlyingSprite extends StatelessWidget {
  final AnimationController controller;
  final String text;
  final int index;
  final double width;
  final double height;

  const _FlyingSprite({
    required this.controller,
    required this.text,
    required this.index,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final topPositions = [0.10, 0.22, 0.36, 0.50, 0.64, 0.76, 0.28];
    final sizes = [34.0, 48.0, 38.0, 56.0, 42.0, 50.0, 36.0];
    final reverse = index.isOdd;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final raw = (controller.value + index * 0.17) % 1.0;
        final curved = Curves.easeInOut.transform(raw);
        final x = reverse
            ? width + 80 - curved * (width + 180)
            : -80 + curved * (width + 180);
        final y = height * topPositions[index % topPositions.length] +
            math.sin((controller.value * 2 * math.pi) + index) * 10;

        return Positioned(
          left: x,
          top: y,
          child: Transform.rotate(
            angle: math.sin(controller.value * 2 * math.pi + index) * 0.18,
            child: Text(
              text,
              style: TextStyle(
                fontSize: sizes[index % sizes.length],
                shadows: const [
                  Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BubblePainter extends CustomPainter {
  final Color color;

  const _BubblePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withAlpha(70);
    canvas.drawCircle(Offset(size.width * .12, size.height * .18), 44, paint);
    canvas.drawCircle(Offset(size.width * .86, size.height * .22), 62, paint);
    canvas.drawCircle(Offset(size.width * .65, size.height * .82), 54, paint);
    canvas.drawCircle(Offset(size.width * .25, size.height * .78), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
