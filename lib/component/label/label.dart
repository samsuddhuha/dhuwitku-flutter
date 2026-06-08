import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

enum LabelSize { small, medium, large }

enum LabelColor { red, orange, dark, green, grey }

class Label extends StatelessWidget {
  final String text;
  final LabelSize size;
  final LabelColor color;
  final VoidCallback? onTap;

  const Label({
    super.key,
    required this.text,
    this.size = LabelSize.small,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize;
    EdgeInsets padding;

    switch (size) {
      case LabelSize.small:
        fontSize = 10;
        padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
        break;
      case LabelSize.medium:
        fontSize = 12;
        padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
        break;
      case LabelSize.large:
        fontSize = 14;
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        break;
    }

    // ===== COLOR MAP =====
    Color textColor;
    Color backgroundColor;

    switch (color) {
      case LabelColor.red:
        textColor = AppColors.white;
        backgroundColor = AppColors.primary;
        break;
      case LabelColor.orange:
        textColor = AppColors.white;
        backgroundColor = AppColors.secondary;
        break;
      case LabelColor.dark:
        textColor = AppColors.white;
        backgroundColor = AppColors.darkGrey;
        break;
      case LabelColor.green:
        textColor = AppColors.white;
        backgroundColor = AppColors.success;
        break;
      case LabelColor.grey:
        textColor = AppColors.white;
        backgroundColor = AppColors.lightGrey;
        break;
    }

    final label = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (onTap == null) return label;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: label,
    );
  }
}
