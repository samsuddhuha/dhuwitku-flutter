import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

class DividerApp extends StatelessWidget {
  final String? centerText;
  final Color lineColor;
  final Color textColor;

  final bool isDashed;
  final double dashWidth;
  final double dashGap;

  final double size;

  const DividerApp({
    super.key,
    this.centerText,
    this.lineColor = AppColors.surfaceGrey,
    this.textColor = AppColors.surfaceGrey,
    this.isDashed = false,
    this.dashWidth = 6,
    this.dashGap = 4,
    this.size = 1, // default divider
  });

  @override
  Widget build(BuildContext context) {
    final hasText = centerText != null && centerText!.trim().isNotEmpty;

    Widget buildLine() {
      return SizedBox(
        width: double.infinity,
        height: size,
        child: CustomPaint(
          painter: _DashLinePainter(
            color: lineColor,
            dashWidth: dashWidth,
            dashGap: dashGap,
            isDashed: isDashed,
            strokeWidth: size,
          ),
        ),
      );
    }

    if (!hasText) return buildLine();

    return Row(
      children: [
        Expanded(child: buildLine()),
        const SizedBox(width: 12),
        Text(
          centerText!,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: buildLine()),
      ],
    );
  }
}

class _DashLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;
  final bool isDashed;
  final double strokeWidth;

  _DashLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.isDashed,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final y = size.height / 2;
    double startX = 0;

    if (!isDashed) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      return;
    }

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashLinePainter old) =>
      old.color != color ||
      old.dashWidth != dashWidth ||
      old.dashGap != dashGap ||
      old.isDashed != isDashed ||
      old.strokeWidth != strokeWidth;
}
