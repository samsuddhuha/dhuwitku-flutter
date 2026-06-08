// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/navbar/navbar.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/core/ui/app_images.dart';
// import 'package:inacash_bisnis/feature/camera/camera_vm.dart';
// import 'package:provider/provider.dart';

// class CameraPage extends StatefulWidget {
//   final bool? isCaptureIdCard;

//   const CameraPage({super.key, this.isCaptureIdCard});

//   @override
//   State<CameraPage> createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   @override
//   Widget build(BuildContext context) {
//     final bool isCaptureIdCard = widget.isCaptureIdCard ?? false;
//     final Gradient activeGradient = const LinearGradient(
//       colors: [AppColors.primary, AppColors.secondary],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     );
//     return ChangeNotifierProvider(
//       create: (_) {
//         final vm = CameraVm(context, isCaptureIdCard);
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           vm.initCamera();
//         });
//         return vm;
//       },
//       child: Consumer<CameraVm>(
//         builder: (context, vm, _) {
//           final double cameraWidth = (MediaQuery.of(context).size.width - 32);
//           final double cameraHeight = cameraWidth * vm.aspectRatioHeight;

//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               appBar: Navbar(title: "Ambil Gambar KTP"),
//               bottomNavigationBar: Container(
//                 padding: EdgeInsets.fromLTRB(
//                   0,
//                   16,
//                   0,
//                   16 + MediaQuery.of(context).padding.bottom,
//                 ),
//                 color: AppColors.secondary,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         vm.takePicture();
//                       },
//                       child: Image.asset(
//                         AppImages.icShutter,
//                         width: 72,
//                         height: 72,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               body: Container(
//                 decoration: BoxDecoration(gradient: activeGradient),
//                 child: SafeArea(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                         child: SizedBox(
//                           height: cameraHeight, // tetap kamu kontrol
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: vm.isInitialized
//                                   ? LayoutBuilder(
//                                       builder: (context, constraints) {
//                                         final previewSize =
//                                             vm.controller!.value.previewSize!;

//                                         final cameraAspect =
//                                             previewSize.height /
//                                             previewSize.width;

//                                         final containerAspect =
//                                             constraints.maxWidth /
//                                             constraints.maxHeight;

//                                         final scale =
//                                             cameraAspect > containerAspect
//                                             ? cameraAspect / containerAspect
//                                             : containerAspect / cameraAspect;

//                                         return ClipRect(
//                                           child: OverflowBox(
//                                             alignment: Alignment.center,
//                                             child: Transform.scale(
//                                               scale: scale,
//                                               child: CameraPreview(
//                                                 vm.controller!,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     )
//                                   : Container(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
