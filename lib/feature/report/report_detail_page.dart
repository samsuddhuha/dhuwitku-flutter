// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/button/transparent_button.dart';
// import 'package:inacash_bisnis/component/divider/divider_app.dart';
// import 'package:inacash_bisnis/component/navbar/navbar.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/core/ui/app_images.dart';
// import 'package:inacash_bisnis/core/ui/text_app.dart';
// import 'package:inacash_bisnis/feature/report/report_detail_vm.dart';
// import 'package:inacash_bisnis/network/remotedata/transaction/model/cash_out_model.dart';
// import 'package:inacash_bisnis/network/remotedata/transaction/model/qris_data_model.dart';
// import 'package:inacash_bisnis/util/extension/date_extension.dart';
// import 'package:inacash_bisnis/util/extension/string_extension.dart';
// import 'package:provider/provider.dart';

// class ReportDetailPage extends StatelessWidget {
//   final QrisDataModel? qrisDataModel;
//   final CashOutModel? cashOutModel;
//   final String? reffCashIn;

//   const ReportDetailPage({
//     super.key,
//     this.qrisDataModel,
//     this.cashOutModel,
//     this.reffCashIn,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final Gradient activeGradient = const LinearGradient(
//       colors: [AppColors.primary, AppColors.secondary],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     );

//     return ChangeNotifierProvider(
//       create: (_) => ReportDetailVm(context, qrisDataModel, cashOutModel),
//       child: Consumer<ReportDetailVm>(
//         builder: (context, vm, _) {
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               appBar: const Navbar(title: "Detail Transaksi"),

//               bottomNavigationBar: Container(
//                 color: AppColors.secondary,
//                 padding: EdgeInsets.fromLTRB(
//                   16,
//                   16,
//                   16,
//                   16 + MediaQuery.of(context).padding.bottom,
//                 ),
//                 child: Row(
//                   children: [
//                     if (vm.qrisDataModel != null ||
//                         vm.cashOutModel != null) ...[
//                       Expanded(
//                         child: TransparentButton(
//                           text: "Unduh",
//                           iconPath: AppImages.icDownload,
//                           onPressed: () {
//                             vm.saveCardToGallery();
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: TransparentButton(
//                           text: "Bagikan",
//                           iconPath: AppImages.icSend,
//                           onPressed: () {
//                             vm.shareCard();
//                           },
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),

//               body: Container(
//                 decoration: BoxDecoration(gradient: activeGradient),
//                 child: SafeArea(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: RepaintBoundary(
//                             key: vm.cardKey,
//                             child: Container(
//                               decoration: vm.isCaptureCard
//                                   ? BoxDecoration(gradient: activeGradient)
//                                   : null,
//                               padding: EdgeInsets.all(16),
//                               child: Stack(
//                                 clipBehavior: Clip.none,
//                                 children: [
//                                   vm.qrisDataModel != null ||
//                                           vm.cashOutModel != null
//                                       ? Container(
//                                           margin: const EdgeInsets.only(
//                                             top: 40,
//                                           ),
//                                           width: double.infinity,
//                                           padding: const EdgeInsets.all(16),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               16,
//                                             ),
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               const SizedBox(height: 40),
//                                               TextApp.body(
//                                                 vm.isReportIn
//                                                     ? "Transaksi QRIS"
//                                                     : "Tarik Saldo",
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               TextApp.xSmall(
//                                                 vm.subtitle ?? '-',
//                                                 textAlign: TextAlign.center,
//                                                 color: AppColors.textSecondary,
//                                               ),
//                                               const SizedBox(height: 12),

//                                               Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                       horizontal: 12,
//                                                     ),
//                                                 decoration: BoxDecoration(
//                                                   color: vm.statusColor
//                                                       .withValues(alpha: 0.15),
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                 ),
//                                                 child: TextApp.small(
//                                                   (vm.status ?? '-')
//                                                       .toLowerCase()
//                                                       .capitalized(),
//                                                   color: vm.statusColor,
//                                                 ),
//                                               ),

//                                               const SizedBox(height: 24),
//                                               _infoRow(
//                                                 "Waktu Transaksi",
//                                                 vm.transactionDate
//                                                     .toDate()
//                                                     .toStringDate(),
//                                               ),
//                                               const SizedBox(height: 12),
//                                               if (vm.qrisDataModel?.paidAt !=
//                                                       null &&
//                                                   vm.isReportIn) ...[
//                                                 _infoRow(
//                                                   "Waktu Pembayaran",
//                                                   vm.qrisDataModel?.paidAt
//                                                           ?.toDate()
//                                                           .toStringDate() ??
//                                                       '-',
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                               ],
//                                               _infoRow("Reff", vm.reff ?? '-'),
//                                               const SizedBox(height: 12),

//                                               if (vm.isReportIn) ...[
//                                                 if (vm
//                                                         .qrisDataModel
//                                                         ?.merchantPan !=
//                                                     null) ...[
//                                                   _infoRow(
//                                                     "Merchant PAN",
//                                                     vm
//                                                             .qrisDataModel
//                                                             ?.merchantPan ??
//                                                         '',
//                                                   ),
//                                                   const SizedBox(height: 12),
//                                                 ],
//                                                 if (vm
//                                                         .qrisDataModel
//                                                         ?.customerPan !=
//                                                     null) ...[
//                                                   _infoRow(
//                                                     "Customer PAN",
//                                                     vm
//                                                             .qrisDataModel
//                                                             ?.customerPan ??
//                                                         '',
//                                                   ),
//                                                   const SizedBox(height: 12),
//                                                 ],
//                                                 if (vm.qrisDataModel?.rrn !=
//                                                     null) ...[
//                                                   _infoRow(
//                                                     "RRN",
//                                                     vm.qrisDataModel?.rrn ?? '',
//                                                   ),
//                                                 ],
//                                               ] else ...[
//                                                 _infoRow(
//                                                   "Produk",
//                                                   vm
//                                                           .cashOutModel
//                                                           ?.productName ??
//                                                       '',
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 _infoRow(
//                                                   "ID Pelanggan",
//                                                   vm.cashOutModel?.custno ?? '',
//                                                 ),
//                                                 if (vm.cashOutModel?.custname !=
//                                                         null &&
//                                                     vm
//                                                         .cashOutModel!
//                                                         .custname
//                                                         .isNotEmpty) ...[
//                                                   const SizedBox(height: 12),
//                                                   _infoRow(
//                                                     "Nama Pelanggan",
//                                                     vm.cashOutModel?.custname ??
//                                                         '',
//                                                   ),
//                                                 ],
//                                                 const SizedBox(height: 12),
//                                                 _infoRow(
//                                                   "Keterangan",
//                                                   vm
//                                                           .cashOutModel
//                                                           ?.productInfo ??
//                                                       '',
//                                                 ),
//                                               ],
//                                               const SizedBox(height: 16),

//                                               DividerApp(
//                                                 isDashed: true,
//                                                 dashWidth: 8,
//                                                 dashGap: 6,
//                                                 lineColor: AppColors.lightGrey,
//                                               ),

//                                               const SizedBox(height: 16),
//                                               _infoRow(
//                                                 "Nominal",
//                                                 vm.nominal.toString().toRupiah(
//                                                   withSymbol: true,
//                                                 ),
//                                               ),
//                                               if (!vm.isReportIn) ...[
//                                                 const SizedBox(height: 12),
//                                                 _infoRow(
//                                                   "Biaya Admin",
//                                                   vm.cashOutModel?.admin
//                                                           .toString()
//                                                           .toRupiah(
//                                                             withSymbol: true,
//                                                           ) ??
//                                                       '',
//                                                 ),
//                                               ],
//                                               const SizedBox(height: 16),

//                                               DividerApp(
//                                                 isDashed: true,
//                                                 dashWidth: 8,
//                                                 dashGap: 6,
//                                                 lineColor: AppColors.lightGrey,
//                                               ),

//                                               const SizedBox(height: 16),
//                                               _infoRow(
//                                                 "Total Transaksi",
//                                                 vm.total.toString().toRupiah(
//                                                   withSymbol: true,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       : SizedBox(
//                                           height:
//                                               MediaQuery.of(
//                                                 context,
//                                               ).size.height *
//                                               0.7,
//                                           child: Center(
//                                             child: CircularProgressIndicator(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),

//                                   if (vm.qrisDataModel != null ||
//                                       vm.cashOutModel != null)
//                                     Positioned(
//                                       top: 0,
//                                       left: 0,
//                                       right: 0,
//                                       child: Center(
//                                         child: Container(
//                                           height: 84,
//                                           width: 84,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Colors.black,
//                                             border: Border.all(
//                                               color: AppColors.primary,
//                                               width: 4,
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: SizedBox(
//                                               height: 40,
//                                               width: 60,
//                                               child: Image.asset(
//                                                 AppImages.logoWhite,
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
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

//   Widget _infoRow(String title, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextApp.xSmall(title, color: AppColors.textSecondary),
//         const SizedBox(width: 12),

//         Expanded(
//           child: TextApp.small(
//             value,
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             maxLines: 3,
//             textAlign: TextAlign.right,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
