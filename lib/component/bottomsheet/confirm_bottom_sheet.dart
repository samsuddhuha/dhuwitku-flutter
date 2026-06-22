import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/button/secondary_button.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:flutter/material.dart';

void showConfirmBottomSheet({
  required BuildContext context,
  required String title,
  required String message,
  required String positiveText,
  required VoidCallback onPositive,
  bool? isDismissible,
  bool? isScrollControlled,
  String? negativeText,
  VoidCallback? onNegative,
  String? imagePath,
  int? marginBottom,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: isDismissible ?? true,
    isScrollControlled: isScrollControlled ?? true,
    enableDrag: isDismissible ?? true,
    backgroundColor: const Color.fromARGB(0, 3, 2, 2),
    builder: (_) {
      return Container(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          8 + MediaQuery.of(context).padding.bottom + (marginBottom ?? 0),
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.surfaceGrey,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 12),

            if (imagePath != null) ...[
              Image.asset(imagePath, width: 80, height: 80),
              const SizedBox(height: 16),
            ],

            // Title
            TextApp.h5(
              title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),

            // Message
            TextApp.small(
              message,
              textAlign: TextAlign.center,
              color: AppColors.darkGrey,
            ),

            const SizedBox(height: 24),

            // 🔹 Buttons (Horizontal)
            Row(
              children: [
                if (negativeText != null && negativeText.trim().isNotEmpty)
                  Expanded(
                    child: SecondaryButton(
                      text: negativeText,
                      isEnabled: true,
                      onPressed: () {
                        Navigator.pop(context);
                        onNegative?.call();
                      },
                    ),
                  ),

                if (negativeText != null && negativeText.trim().isNotEmpty)
                  const SizedBox(width: 16),

                Expanded(
                  child: PrimaryButton(
                    text: positiveText,
                    isEnabled: true,
                    onPressed: () {
                      Navigator.pop(context);
                      onPositive();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
