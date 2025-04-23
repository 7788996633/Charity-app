import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key});

  @override
  CustomLoadingIndicatorState createState() => CustomLoadingIndicatorState();
}

class CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ArcPainter(_controller.value),
          child: const SizedBox(
            width: 100,
            height: 100,
          ),
        );
      },
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress;

  ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final double width = size.width;
    final double height = size.height;
    final Rect rect = Rect.fromLTWH(0.0, 0.0, width, height);

    // Draw the green arc
    paint.color = Colors.green;
    canvas.drawArc(rect, progress * 2 * 3.141592653589793,
        2 * 3.141592653589793 / 3, false, paint);

    // Draw the red arc
    paint.color = Colors.red;
    canvas.drawArc(
        rect,
        progress * 2 * 3.141592653589793 + 2 * 3.141592653589793 / 3,
        2 * 3.141592653589793 / 3,
        false,
        paint);

    // Draw the yellow arc
    paint.color = Colors.yellow;
    canvas.drawArc(
        rect,
        progress * 2 * 3.141592653589793 + 4 * 3.141592653589793 / 3,
        2 * 3.141592653589793 / 3,
        false,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
