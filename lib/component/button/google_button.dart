import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;
  final String text;

  const GoogleButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.text = 'Masuk dengan Google',
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isEnabled && !isLoading;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        onPressed: active ? onPressed : null,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: AppColors.darkGrey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Google logo (asset)
                  Image.asset(AppImages.icGoogle, width: 20, height: 20),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white, // warna teks saat tombol aktif
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
