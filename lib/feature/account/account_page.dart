// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/component/navbar/navbar.dart';
// import 'package:inacash_ewallet/core/ui/app_colors.dart';
// import 'package:inacash_ewallet/core/ui/app_images.dart';
// import 'package:inacash_ewallet/core/ui/text_app.dart';
// import 'package:inacash_ewallet/feature/account/account_vm.dart';
// import 'package:provider/provider.dart';

// class AccountPage extends StatelessWidget {
//   const AccountPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AccountVm(context),
//       child: Consumer<AccountVm>(
//         builder: (context, vm, _) {
//           return Scaffold(
//             extendBodyBehindAppBar: true,
//             extendBody: true,
//             appBar: Navbar(title: ''),
//             body: Container(
//               width: double.infinity,
//               height: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(AppImages.bgBlackRed),
//                   fit: BoxFit.cover, // penting biar full layar
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             _buildProfileInfoItem(),

//                             SizedBox(height: 32),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: _buildMenuItem(
//                                     title: "Langganan",
//                                     iconPath: AppImages.icPayment,
//                                   ),
//                                 ),
//                                 SizedBox(width: 20),
//                                 Expanded(
//                                   child: _buildMenuItem(
//                                     title: "Undang teman",
//                                     iconPath: AppImages.icTransfer,
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             SizedBox(height: 20),
//                             _buildMenuCard(),

//                             SizedBox(height: 20),
//                             GestureDetector(
//                               onTap: () {
//                                 vm.logout();
//                               },
//                               child: TextApp.h4(
//                                 "Keluar akun",
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
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

//   Widget _buildProfileInfoItem() {
//     return Column(
//       children: [
//         Image.asset(AppImages.icUserBlue, fit: BoxFit.contain, width: 80),
//         SizedBox(height: 12),
//         TextApp.h1("Inacash Ina", fontWeight: FontWeight.bold),
//         SizedBox(height: 4),
//         TextApp.h4("0812345678910"),
//       ],
//     );
//   }

//   Widget _buildMenuItem({
//     required String title,
//     required String iconPath,
//     VoidCallback? onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(32),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(32),
//               color: Colors.white.withValues(alpha: 0.10),
//               border: Border.all(
//                 color: Colors.white.withValues(alpha: 0.20),
//                 width: 1,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   iconPath,
//                   width: 24,
//                   height: 24,
//                   color: Colors.white,
//                   colorBlendMode: BlendMode.srcIn,
//                 ),
//                 const SizedBox(height: 24),

//                 TextApp.small(
//                   title,
//                   color: Colors.white,
//                   textAlign: TextAlign.center,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 const SizedBox(height: 4),
//                 TextApp.xSmall(
//                   'Daftar tagihan anda',
//                   color: AppColors.grey,
//                   textAlign: TextAlign.center,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuCard() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(32),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(32),
//             color: Colors.white.withValues(alpha: 0.10),
//             border: Border.all(
//               color: Colors.white.withValues(alpha: 0.20),
//               width: 1,
//             ),
//           ),

//           child: Column(
//             children: [
//               _buildProfileMenuItem(
//                 title: "Bantuan",
//                 iconPath: AppImages.icCircleHelp,
//                 onTap: () async {},
//               ),
//               SizedBox(height: 16),
//               _buildProfileMenuItem(
//                 title: "Akun",
//                 iconPath: AppImages.icCircleUser,
//                 onTap: () async {},
//               ),
//               SizedBox(height: 16),
//               _buildProfileMenuItem(
//                 title: "Privasi & keamanan",
//                 iconPath: AppImages.icCircleSecurity,
//                 onTap: () async {},
//               ),
//               SizedBox(height: 16),
//               _buildProfileMenuItem(
//                 title: "Pemberitahuan",
//                 iconPath: AppImages.icCircleNotification,
//                 onTap: () async {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileMenuItem({
//     required String title,
//     required String iconPath,
//     VoidCallback? onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Row(
//           children: [
//             Image.asset(
//               iconPath,
//               width: 26,
//               height: 26,
//               fit: BoxFit.contain,
//               color: AppColors.white,
//             ),

//             const SizedBox(width: 16),

//             Expanded(child: TextApp.h5(title, fontWeight: FontWeight.w500)),
//           ],
//         ),
//       ),
//     );
//   }
// }
