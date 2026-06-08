import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;

  const TransparentButton({
    super.key,
    required this.text,
    this.iconPath,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Colors.white.withValues(alpha: 0.16);
    final Color disabledBackground = Colors.white.withValues(alpha: 0.08);
    final Color textColor = Colors.white;
    final Color disabledTextColor = Colors.white.withValues(alpha: 0.5);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? backgroundColor : disabledBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconPath != null) ...[
                    Image.asset(
                      iconPath!,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                      color: textColor,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isEnabled ? textColor : disabledTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
