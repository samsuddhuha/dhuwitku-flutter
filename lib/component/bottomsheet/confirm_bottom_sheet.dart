import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/button/secondary_button.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:flutter/material.dart';

// void showConfirmBottomSheet({
//   required BuildContext context,
//   required String title,
//   required String message,
//   required String positiveText,
//   required VoidCallback onPositive,
//   bool? isDismissible,
//   bool? isScrollControlled,
//   String? negativeText,
//   VoidCallback? onNegative,
//   String? imagePath,
//   int? marginBottom,
// }) {
//   showModalBottomSheet(
//     context: context,
//     isDismissible: isDismissible ?? true,
//     isScrollControlled: isScrollControlled ?? true,
//     enableDrag: isDismissible ?? true,
//     backgroundColor: const Color.fromARGB(0, 3, 2, 2),
//     builder: (_) {
//       return Container(
//         padding: EdgeInsets.fromLTRB(
//           16,
//           16,
//           16,
//           16 + MediaQuery.of(context).padding.bottom + (marginBottom ?? 0),
//         ),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Drag handle
//             Container(
//               width: 48,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: AppColors.surfaceGrey,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//             const SizedBox(height: 16),

//             if (imagePath != null) ...[
//               Image.asset(imagePath, width: 80, height: 80),
//               const SizedBox(height: 16),
//             ],

//             // Title
//             TextApp.h5(
//               title,
//               textAlign: TextAlign.center,
//               fontWeight: FontWeight.bold,
//             ),
//             const SizedBox(height: 8),

//             // Message
//             TextApp.small(
//               message,
//               textAlign: TextAlign.center,
//               color: AppColors.grey,
//             ),

//             const SizedBox(height: 24),

//             // 🔹 Buttons (Horizontal)
//             Row(
//               children: [
//                 if (negativeText != null && negativeText.trim().isNotEmpty)
//                   Expanded(
//                     child: SecondaryButton(
//                       text: negativeText,
//                       isEnabled: true,
//                       onPressed: () {
//                         Navigator.pop(context);
//                         onNegative?.call();
//                       },
//                     ),
//                   ),

//                 if (negativeText != null && negativeText.trim().isNotEmpty)
//                   const SizedBox(width: 16),

//                 Expanded(
//                   child: PrimaryButton(
//                     text: positiveText,
//                     isEnabled: true,
//                     onPressed: () {
//                       Navigator.pop(context);
//                       onPositive();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

import 'dart:ui';

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

    // penting
    backgroundColor: Colors.transparent,

    builder: (_) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),

                // glass effect
                color: Colors.white.withOpacity(0.12),

                // border glass
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.2,
                ),

                // optional shadow
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // drag handle
                  // Container(
                  //   width: 48,
                  //   height: 5,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.4),
                  //     borderRadius: BorderRadius.circular(100),
                  //   ),
                  // ),
                  const SizedBox(height: 8),

                  if (imagePath != null) ...[
                    Image.asset(imagePath, width: 44, height: 44),
                    const SizedBox(height: 16),
                  ],

                  TextApp.h5(
                    title,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 8),

                  TextApp.small(
                    message,
                    textAlign: TextAlign.center,
                    color: Colors.white.withOpacity(0.8),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      if (negativeText != null &&
                          negativeText.trim().isNotEmpty)
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

                      if (negativeText != null &&
                          negativeText.trim().isNotEmpty)
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
            ),
          ),
        ),
      );
    },
  );
}
