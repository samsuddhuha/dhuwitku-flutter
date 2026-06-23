import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

enum LabelSize { small, medium, large }

enum LabelColor { green, grey }

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
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ===== FONT SIZE MAP =====
    double fontSize;
    switch (size) {
      case LabelSize.small:
        fontSize = 12;
        break;
      case LabelSize.medium:
        fontSize = 14;
        break;
      case LabelSize.large:
        fontSize = 16;
        break;
    }

    // ===== COLOR MAP =====
    Color textColor;
    Color borderColor;

    switch (color) {
      case LabelColor.green:
        textColor = AppColors.tundora;
        borderColor = AppColors.primaryDark.withValues(alpha: 1);
        break;

      case LabelColor.grey:
        textColor = AppColors.grey;
        borderColor = AppColors.grey.withValues(alpha: 1);
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
