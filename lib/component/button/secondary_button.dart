import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Colors.white;
    final Color disabledColor = Colors.grey.shade300;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? activeColor : disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.tundora, width: 1),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.tundora,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tundora,
                ),
              ),
      ),
    );
  }
}
