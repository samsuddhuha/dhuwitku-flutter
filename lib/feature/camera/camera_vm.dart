// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:inacash_bisnis/core/base/base_vm.dart';

// class CameraVm extends BaseVm {
//   final BuildContext context;
//   final bool isCaptureIdCard;

//   CameraVm(this.context, this.isCaptureIdCard);

//   CameraController? controller;
//   bool isInitialized = false;

//   XFile? capturedImage;

//   double get aspectRatioHeight => isCaptureIdCard ? 0.65 : 1.5;

//   Future<void> initCamera() async {
//     try {
//       final cameras = await availableCameras();

//       controller = CameraController(
//         cameras.first,
//         ResolutionPreset.high,
//         enableAudio: false,
//         imageFormatGroup: ImageFormatGroup.yuv420,
//       );

//       await controller!.initialize();

//       isInitialized = true;
//       notifyListeners();
//     } catch (e) {
//       print("❌ Camera error: $e");
//     }
//   }

//   Future<void> takePicture() async {
//     if (controller == null || !controller!.value.isInitialized) return;

//     try {
//       final raw = await controller!.takePicture();

//       final compressed = await _compressImage(raw);

//       await File(raw.path).delete();

//       capturedImage = compressed;

//       if (!context.mounted) return;
//       Navigator.pop(context, capturedImage);
//     } catch (e) {
//       debugPrint('❌ Capture error: $e');
//     }
//   }

//   // Future<XFile> _compressImage(XFile file) async {
//   //   final bytes = await File(file.path).readAsBytes();
//   //   final image = img.decodeImage(bytes);
//   //   if (image == null) return file;

//   //   img.Image processed = image;

//   //   // 🔹 resize max width 1280
//   //   if (processed.width > 1280) {
//   //     processed = img.copyResize(
//   //       processed,
//   //       width: 1280,
//   //       interpolation: img.Interpolation.average,
//   //     );
//   //   }

//   //   final originalPath = file.path;
//   //   final lastSlash = originalPath.lastIndexOf('/');
//   //   final dir = originalPath.substring(0, lastSlash);
//   //   final name = originalPath.substring(lastSlash + 1).split('.').first;

//   //   final newPath = '$dir/${name}_id_card.jpg';

//   //   const maxSizeBytes = 3 * 1024 * 1024; // 2MB
//   //   int quality = 85;
//   //   late List<int> jpgBytes;

//   //   do {
//   //     jpgBytes = img.encodeJpg(processed, quality: quality);
//   //     quality -= 5;
//   //   } while (jpgBytes.length > maxSizeBytes && quality >= 40);

//   //   await File(newPath).writeAsBytes(jpgBytes);

//   //   debugPrint(
//   //     '📦 result camera final size: '
//   //     '${(jpgBytes.length / (1024 * 1024)).toStringAsFixed(2)} MB',
//   //   );

//   //   return XFile(newPath);
//   // }

//   Future<XFile> _compressImage(XFile file) async {
//     final bytes = await File(file.path).readAsBytes();
//     final image = img.decodeImage(bytes);
//     if (image == null) return file;

//     img.Image processed = image;

//     final previewAspect = 1 / (aspectRatioHeight + 0.02);

//     final newHeight = (processed.width / previewAspect).round();
//     final y = ((processed.height - newHeight) / 2).round();

//     processed = img.copyCrop(
//       processed,
//       x: 0,
//       y: y,
//       width: processed.width,
//       height: newHeight,
//     );

//     // 🔹 resize max width 1280
//     if (processed.width > 1280) {
//       processed = img.copyResize(
//         processed,
//         width: 1280,
//         interpolation: img.Interpolation.average,
//       );
//     }

//     final originalPath = file.path;
//     final lastSlash = originalPath.lastIndexOf('/');
//     final dir = originalPath.substring(0, lastSlash);
//     final name = originalPath.substring(lastSlash + 1).split('.').first;

//     final newPath = '$dir/${name}_id_card.jpg';

//     const maxSizeBytes = 3 * 1024 * 1024; // 3MB
//     int quality = 85;
//     late List<int> jpgBytes;

//     do {
//       jpgBytes = img.encodeJpg(processed, quality: quality);
//       quality -= 5;
//     } while (jpgBytes.length > maxSizeBytes && quality >= 40);

//     await File(newPath).writeAsBytes(jpgBytes);

//     debugPrint(
//       '📦 result camera final size: '
//       '${(jpgBytes.length / (1024 * 1024)).toStringAsFixed(2)} MB',
//     );

//     return XFile(newPath);
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
