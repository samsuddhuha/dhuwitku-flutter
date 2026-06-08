// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/navbar/navbar.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/core/ui/app_images.dart';
// import 'package:inacash_bisnis/core/ui/text_app.dart';
// import 'package:inacash_bisnis/feature/account/help_vm.dart';
// import 'package:provider/provider.dart';

// class HelpPage extends StatelessWidget {
//   const HelpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => HelpVm(context),
//       child: Consumer<HelpVm>(
//         builder: (context, vm, _) {
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               appBar: Navbar(title: "Pusat Bantuan"),
//               backgroundColor: AppColors.primary,
//               body: SafeArea(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 48),

//                     Center(
//                       child: Image.asset(
//                         AppImages.logoWhite,
//                         fit: BoxFit.contain,
//                         width: 270,
//                       ),
//                     ),

//                     const SizedBox(height: 48),

//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(32),
//                             topRight: Radius.circular(32),
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Positioned.fill(
//                               bottom: 48,
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Image.asset(
//                                   AppImages.bgFlow,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Column(
//                               children: [
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(height: 24),
//                                         TextApp.small(
//                                           'Halo InaFriends!',
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         const SizedBox(height: 2),
//                                         TextApp.small(
//                                           'Butuh bantuan apa nih?',
//                                           color: AppColors.grey,
//                                         ),
//                                         const SizedBox(height: 32),
//                                         _buildMenuItem(
//                                           title: "081119216665",
//                                           subtitle: "Whatsapp Inacash Bisnis",
//                                           iconPath: AppImages.icWhatsApp,
//                                           onTap: () {
//                                             vm.openWhatsApp(
//                                               '6281119216665',
//                                               message:
//                                                   'Halo Inacash Bisnis, saya butuh bantuan',
//                                             );
//                                           },
//                                         ),
//                                         const SizedBox(height: 16),
//                                         _buildMenuItem(
//                                           title: "info@inacashbisnis.co.id",
//                                           subtitle: "Email Inacash Bisnis",
//                                           iconPath: AppImages.icMail,
//                                           onTap: () {
//                                             vm.openEmail(
//                                               'info@inacashbisnis.co.id',
//                                               subject: 'Bantuan Inacash Bisnis',
//                                               body:
//                                                   'Halo tim Inacash,\n\nSaya ingin bertanya terkait',
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.fromLTRB(
//                   16,
//                   16,
//                   16,
//                   16 + MediaQuery.of(context).padding.bottom,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextApp.small(
//                       "Version",
//                       color: AppColors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     const SizedBox(width: 4),
//                     TextApp.small(
//                       vm.version,
//                       color: AppColors.textPrimary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required String title,
//     required String subtitle,
//     required String iconPath,
//     VoidCallback? onTap,
//   }) {
//     final Gradient activeGradient = const LinearGradient(
//       colors: [AppColors.secondary, AppColors.primary],
//       begin: Alignment.centerLeft,
//       end: Alignment.centerRight,
//     );
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: activeGradient,
//           borderRadius: BorderRadius.circular(24),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//         child: Row(
//           children: [
//             Image.asset(
//               iconPath,
//               width: 26,
//               height: 26,
//               fit: BoxFit.contain,
//               color: AppColors.white,
//             ),

//             const SizedBox(width: 20),

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextApp.body(
//                     title,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.white,
//                   ),
//                   const SizedBox(height: 4),
//                   TextApp.small(subtitle, color: AppColors.white),
//                 ],
//               ),
//             ),

//             const SizedBox(width: 8),
//             const Icon(Icons.chevron_right, color: AppColors.white, size: 26),
//           ],
//         ),
//       ),
//     );
//   }
// }
