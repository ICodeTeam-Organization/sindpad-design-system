import 'package:flutter/material.dart';

/// A custom stylized 3-bar menu icon matching the Sindbad design identity
/// (full top bar, shortened middle bar, full bottom bar with rounded caps).
class SindbadMenuIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const SindbadMenuIcon({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? IconTheme.of(context).color ?? Theme.of(context).colorScheme.onSurface;

    return CustomPaint(
      size: Size(size, size),
      painter: _SindbadMenuIconPainter(color: effectiveColor),
    );
  }
}

class _SindbadMenuIconPainter extends CustomPainter {
  final Color color;

  const _SindbadMenuIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = (size.height * 0.12).clamp(2.0, 3.5);
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final startX = strokeWidth / 2;
    final endX = size.width - (strokeWidth / 2);
    final middleEndX = startX + (endX - startX) * 0.55;

    final topY = size.height * 0.22;
    final middleY = size.height * 0.50;
    final bottomY = size.height * 0.78;

    // Top Bar (Full)
    canvas.drawLine(Offset(startX, topY), Offset(endX, topY), paint);

    // Middle Bar (Shortened)
    canvas.drawLine(Offset(startX, middleY), Offset(middleEndX, middleY), paint);

    // Bottom Bar (Full)
    canvas.drawLine(Offset(startX, bottomY), Offset(endX, bottomY), paint);
  }

  @override
  bool shouldRepaint(covariant _SindbadMenuIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
