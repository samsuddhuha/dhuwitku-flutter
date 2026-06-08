// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/navbar/navbar.dart';
// import 'package:inacash_bisnis/core/base/base_vm.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/core/ui/app_images.dart';
// import 'package:inacash_bisnis/core/ui/text_app.dart';
// import 'package:inacash_bisnis/feature/register/register_merchant_page.dart';
// import 'package:provider/provider.dart';

// class RegisterMerchantOnboardingPage extends StatelessWidget {
//   const RegisterMerchantOnboardingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => BaseVm(),
//       child: Consumer<BaseVm>(
//         builder: (context, vm, _) {
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               appBar: Navbar(title: "Daftar Merchant"),
//               backgroundColor: AppColors.primary,
//               body: SafeArea(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(32),
//                       topRight: Radius.circular(32),
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         bottom: 48,
//                         child: Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Image.asset(
//                             AppImages.bgFlow,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: SingleChildScrollView(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 24),
//                                   TextApp.small(
//                                     'Pilih tujuan pemakaian',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   const SizedBox(height: 24),
//                                   _buildMenuItem(
//                                     title: "INDIVIDUAL",
//                                     subtitle:
//                                         "Untuk pemilik usaha perorangan. Cocok bagi freelancer, UMKM, atau usaha kecil tanpa badan hukum.",
//                                     iconPath: AppImages.icIndividu,
//                                     onTap: () async {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => RegisterMerchantPage(
//                                             isCompany: false,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   const SizedBox(height: 8),
//                                   _buildMenuItem(
//                                     title: "PERUSAHAAN",
//                                     subtitle:
//                                         "Untuk badan usaha resmi. Cocok bagi perusahaan dengan dokumen legal seperti NPWP perusahaan.",
//                                     iconPath: AppImages.icPeople,
//                                     onTap: () async {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => RegisterMerchantPage(
//                                             isCompany: true,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
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
//                 child: SizedBox(),
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
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
//         child: Row(
//           children: [
//             Image.asset(
//               iconPath,
//               width: 26,
//               height: 26,
//               fit: BoxFit.contain,
//               color: AppColors.secondary,
//             ),

//             const SizedBox(width: 20),

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextApp.body(title, fontWeight: FontWeight.w500),
//                   const SizedBox(height: 4),
//                   TextApp.small(subtitle, color: AppColors.silver),
//                 ],
//               ),
//             ),

//             const SizedBox(width: 8),
//             const Icon(
//               Icons.chevron_right,
//               color: AppColors.darkGrey,
//               size: 26,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
