// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/component/field/input_field.dart';
// import 'package:inacash_ewallet/core/ui/app_colors.dart';
// import 'package:inacash_ewallet/core/ui/app_images.dart';
// import 'package:inacash_ewallet/core/ui/text_app.dart';
// import 'package:inacash_ewallet/feature/account/account_page.dart';
// import 'package:inacash_ewallet/feature/report/report_vm.dart';
// import 'package:inacash_ewallet/main.dart';
// import 'package:provider/provider.dart';

// class ReportPage extends StatefulWidget {
//   const ReportPage({super.key});

//   @override
//   State<ReportPage> createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> with RouteAware {
//   ReportVm? _vm;
//   late TabController _tabController;
//   int _currentIndex = 0;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _tabController = TabController(length: 2, vsync: this);
//   //   _tabController.addListener(() {
//   //     _vm?.changeTab(_tabController.index);
//   //   });
//   //   _loadSelectedIndexTabReport();
//   // }

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
//     //   await _vm!.getMerchant();
//     //   await Session.instance.setReloadMerchant(false);
//     // }

//     // await Session.instance.loadIsReloadData();
//     // if (Session.instance.isReloadData) {
//     //   _vm!.pageReportIn = 1;
//     //   _vm!.pageReportOut = 1;
//     //   await _vm!.getListTransaction();
//     //   await Session.instance.setReloadData(false);
//     // }
//   }

//   // Future<void> _loadSelectedIndexTabReport() async {
//   //   final result = await Session.instance.getSelectedIndexTabReport();
//   //   await Session.instance.setSelectedIndexTabReport(0);
//   //   setState(() {
//   //     _currentIndex = result ?? 0;
//   //     _vm?.changeTab(_currentIndex);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
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
//     return ChangeNotifierProvider(
//       create: (context) {
//         final vm = ReportVm(context);
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           vm.init();
//         });
//         return vm;
//       },
//       child: Consumer<ReportVm>(
//         builder: (context, vm, _) {
//           _vm = vm;
//           return Scaffold(
//             // bottomNavigationBar: Container(
//             //   color: AppColors.white,
//             //   padding: EdgeInsets.fromLTRB(
//             //     16,
//             //     16,
//             //     16,
//             //     60 + MediaQuery.of(context).padding.bottom,
//             //   ),
//             //   child: SizedBox(),
//             // ),
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
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 14, bottom: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 12),
//                               child: InputField(
//                                 title: '',
//                                 hintText: 'Cari',
//                                 leftIconPath: AppImages.icSearch,
//                                 controller: vm.searchController,
//                                 onChanged: vm.onSearch,
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const AccountPage(),
//                                 ),
//                               );
//                             },
//                             child: Image.asset(
//                               AppImages.icUserBlue,
//                               fit: BoxFit.contain,
//                               width: 40,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     Expanded(
//                       child: ListView.separated(
//                         itemCount: dummyTransactions.length,
//                         separatorBuilder: (_, __) =>
//                             Divider(color: Colors.transparent, height: 24),
//                         itemBuilder: (context, index) {
//                           final item = dummyTransactions[index];

//                           return InkWell(
//                             borderRadius: BorderRadius.circular(16),
//                             onTap: () {},
//                             child: _buildTransactionItem(
//                               iconPath: item["icon"] as String,
//                               iconColor: AppColors.secondary,
//                               date: item["date"] as String,
//                               description: item["description"] as String,
//                               price: item["price"] as String,
//                             ),
//                           );
//                         },
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

//   // Widget _buildEmptyState(bool isReportIn) {
//   //   return Center(
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       children: [
//   //         const SizedBox(height: 16),
//   //         TextApp.small(
//   //           'Belum ada transaksi ${isReportIn ? 'masuk' : 'keluar'}',
//   //           fontWeight: FontWeight.w600,
//   //           color: AppColors.textPrimary,
//   //         ),
//   //         const SizedBox(height: 8),
//   //         TextApp.xSmall(
//   //           'Transaksi ${isReportIn ? 'masuk' : 'keluar'} akan muncul di sini',
//   //           color: AppColors.textSecondary,
//   //           textAlign: TextAlign.center,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
