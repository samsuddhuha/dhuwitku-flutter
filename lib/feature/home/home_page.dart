// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/core/ui/app_colors.dart';
// import 'package:inacash_ewallet/core/ui/app_images.dart';
// import 'package:inacash_ewallet/core/ui/text_app.dart';
// import 'package:inacash_ewallet/feature/account/account_page.dart';
// import 'package:inacash_ewallet/feature/home/home_vm.dart';
// import 'package:inacash_ewallet/main.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with RouteAware {
//   HomeVm? _vm;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final route = ModalRoute.of(context);
//     if (route is PageRoute) {
//       routeObserver.subscribe(this, route);
//     }
//   }

//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }

//   @override
//   Future<void> didPopNext() async {
//     // await Session.instance.loadIsReloadMerchant();
//     // if (Session.instance.isReloadMerchant) {
//     //   await _vm?.getMerchant();
//     //   await Session.instance.setReloadMerchant(false);
//     // }

//     // await Session.instance.loadIsReloadData();
//     // if (Session.instance.isReloadData) {
//     //   await _vm?.getBalance();
//     //   await _vm?.getListTransaction();
//     //   await Session.instance.setReloadData(false);
//     // }

//     // final isLoadPinStatus = await Session.instance.isLoadPinStatus();
//     // if (isLoadPinStatus ?? false) {
//     //   await _vm?.getPinStatus();
//     //   await Session.instance.setLoadPinStatus(false);
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) {
//         final vm = HomeVm(context);
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           vm.init();
//         });
//         return vm;
//       },
//       child: Consumer<HomeVm>(
//         builder: (context, vm, _) {
//           _vm = vm;
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               body: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(AppImages.bgBlackRed),
//                     fit: BoxFit.cover, // penting biar full layar
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 0,
//                           right: 0,
//                           top: 14,
//                           bottom: 16,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image.asset(
//                               AppImages.logoWhite,
//                               fit: BoxFit.contain,
//                               width: 120,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => const AccountPage(),
//                                   ),
//                                 );
//                               },
//                               child: Image.asset(
//                                 AppImages.icUserBlue,
//                                 fit: BoxFit.contain,
//                                 width: 40,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: 56),
//                       _buildBalanceActions(vm),

//                       SizedBox(height: 56),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildMenuItem(
//                             title: "Top up",
//                             iconPath: AppImages.icPlus,
//                           ),

//                           _buildMenuItem(
//                             title: "Transfer",
//                             iconPath: AppImages.icTransfer,
//                           ),

//                           _buildMenuItem(
//                             title: "Payment",
//                             iconPath: AppImages.icPayment,
//                           ),

//                           _buildMenuItem(
//                             title: "Lainnya",
//                             iconPath: AppImages.icMore,
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 48),
//                       _buildHistoryCard(vm),
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

//   Widget _buildBalanceActions(HomeVm vm) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextApp.small('Pribadi · Inacash', color: AppColors.white),
//           SizedBox(height: 12),
//           TextApp.h1(
//             'Rp 1.874.331',
//             color: AppColors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required String title,
//     required String iconPath,
//     VoidCallback? onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,

//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(100),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
//               child: Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withValues(alpha: 0.10),
//                   border: Border.all(
//                     color: Colors.white.withValues(alpha: 0.20),
//                     width: 1,
//                   ),
//                 ),
//                 child: Center(
//                   child: Image.asset(
//                     iconPath,
//                     width: 18,
//                     height: 18,
//                     color: Colors.white,
//                     colorBlendMode: BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 8),

//           TextApp.small(
//             title,
//             color: Colors.white,
//             textAlign: TextAlign.center,
//             fontWeight: FontWeight.w500,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHistoryCard(HomeVm vm) {
//     final dummyTransactions = [
//       {
//         "icon": AppImages.icPayment,
//         "date": "Hari ini, 09:50",
//         "description": "Bopet Mini",
//         "price": "- Rp 119.000",
//       },
//       {
//         "icon": AppImages.icTransfer,
//         "date": "Hari ini, 08:12",
//         "description": "Top Up Saldo",
//         "price": "+ Rp 500.000",
//       },
//       {
//         "icon": AppImages.icTransfer,
//         "date": "Kemarin, 21:14",
//         "description": "Transfer ke Andi",
//         "price": "- Rp 75.000",
//       },
//     ];

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
//               ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: dummyTransactions.length,
//                 separatorBuilder: (_, __) => Divider(
//                   color: Colors.black.withValues(alpha: 0),
//                   height: 24,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = dummyTransactions[index];
//                   return InkWell(
//                     borderRadius: BorderRadius.circular(16),
//                     onTap: () {},
//                     child: _buildTransactionItem(
//                       iconPath: item["icon"] as String,
//                       iconColor: AppColors.secondary,
//                       date: item["date"] as String,
//                       description: item["description"] as String,
//                       price: item["price"] as String,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionItem({
//     bool showNumber = false,
//     int? number,
//     required String iconPath,
//     required Color iconColor,
//     required String description,
//     required String date,
//     required String price,
//   }) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(0, 4, 0, 10),
//       child: Row(
//         children: [
//           if (showNumber) ...[
//             TextApp.xSmall(number.toString(), fontWeight: FontWeight.w600),
//             const SizedBox(width: 12),
//           ],

//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Image.asset(
//                 iconPath,
//                 width: 18,
//                 height: 18,
//                 fit: BoxFit.contain,
//                 color: iconColor,
//               ),
//             ),
//           ),

//           const SizedBox(width: 12),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextApp.h5(
//                   description,
//                   color: AppColors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 const SizedBox(height: 4),
//                 TextApp.small(
//                   date,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   color: AppColors.grey,
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(width: 12),

//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               TextApp.small(
//                 price,
//                 color: AppColors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildEmptyState() {
//   //   return Center(
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       children: [
//   //         TextApp.small(
//   //           'Belum ada transaksi',
//   //           fontWeight: FontWeight.w600,
//   //           color: AppColors.textPrimary,
//   //         ),
//   //         const SizedBox(height: 8),
//   //         TextApp.xSmall(
//   //           'Transaksi masuk akan muncul di sini',
//   //           color: AppColors.textSecondary,
//   //           textAlign: TextAlign.center,
//   //         ),
//   //         const SizedBox(height: 24),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
