// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:gallery_saver_plus/gallery_saver.dart';
// import 'package:inacash_bisnis/core/base/base_vm.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/network/remotedata/transaction/model/cash_out_model.dart';
// import 'package:inacash_bisnis/network/remotedata/transaction/model/qris_data_model.dart';
// import 'package:inacash_bisnis/util/helper/photo_saver.dart';
// import 'package:inacash_bisnis/util/helper/snackbar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';

// class ReportDetailVm extends BaseVm {
//   final BuildContext context;
//   final QrisDataModel? qrisDataModel;
//   final CashOutModel? cashOutModel;

//   final GlobalKey cardKey = GlobalKey();

//   ReportDetailVm(this.context, this.qrisDataModel, this.cashOutModel) {
//     init();
//   }

//   bool isCaptureCard = false;

//   Future<void> init() async {}

//   bool get isReportIn => qrisDataModel != null;

//   String? get subtitle => isReportIn
//       ? "Merchant ${qrisDataModel?.name ?? '-'}"
//       : cashOutModel?.productName;

//   String? get status =>
//       isReportIn ? qrisDataModel?.status : cashOutModel?.status;

//   String get transactionDate => isReportIn
//       ? qrisDataModel?.createdAt ?? ''
//       : cashOutModel?.createdAt ?? '';

//   String? get reff => isReportIn ? qrisDataModel?.reff : cashOutModel?.reff;

//   Color get statusColor => status?.toUpperCase() == 'SUCCESS'
//       ? AppColors.green
//       : status?.toUpperCase() == 'PENDING'
//       ? AppColors.secondary
//       : status?.toUpperCase() == 'FAILED'
//       ? AppColors.error
//       : status?.toUpperCase() == 'EXPIRED'
//       ? AppColors.grey
//       : AppColors.grey;

//   int get nominal =>
//       isReportIn ? qrisDataModel?.amount ?? 0 : cashOutModel?.price ?? 0;
//   int get total =>
//       isReportIn ? qrisDataModel?.amount ?? 0 : cashOutModel?.total ?? 0;

//   Future<Uint8List> _captureCard() async {
//     isCaptureCard = true;
//     notifyListeners();

//     await Future.delayed(const Duration(milliseconds: 50));

//     final boundary =
//         cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

//     if (boundary == null) {
//       throw Exception('Gagal mengambil gambar');
//     }

//     final image = await boundary.toImage(pixelRatio: 3);
//     final byteData = await image.toByteData(format: ImageByteFormat.png);

//     if (byteData == null) {
//       throw Exception('Gagal memproses gambar');
//     }

//     isCaptureCard = false;
//     notifyListeners();
//     return byteData.buffer.asUint8List();
//   }

//   Future<void> shareCard() async {
//     try {
//       showLoading(context, true);

//       final bytes = await _captureCard();
//       final dir = await getTemporaryDirectory();
//       final file = File('${dir.path}/transaction.png');
//       await file.writeAsBytes(bytes);

//       showLoading(context, false);

//       await Future.delayed(const Duration(milliseconds: 150));

//       final RenderBox box =
//           cardKey.currentContext!.findRenderObject() as RenderBox;

//       await Share.shareXFiles(
//         [XFile(file.path)],
//         text: 'Bukti Transaksi QRIS',
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
//       );
//     } catch (e) {
//       print("ERROR SHARE: $e");
//     }
//   }

//   Future<void> saveCardToGallery() async {
//     if (Platform.isIOS) {
//       await _saveCardToGalleryiOS();
//     } else {
//       await _saveCardToGalleryAndroid();
//     }
//   }

//   Future<void> _saveCardToGalleryAndroid() async {
//     try {
//       showLoading(context, true);

//       final Uint8List bytes = await _captureCard();

//       final dir = await getTemporaryDirectory();
//       final fileName =
//           'bukti_transfer_${DateTime.now().millisecondsSinceEpoch}.png';
//       final file = File('${dir.path}/$fileName');

//       await file.writeAsBytes(bytes);

//       final bool? success = await GallerySaver.saveImage(file.path);

//       if (success != true) {
//         throw Exception('Gagal menyimpan ke galeri');
//       }

//       SnackbarHelper.show(context, 'Bukti transaksi berhasil disimpan');
//     } catch (e) {
//       setError(context, e.toString());
//     } finally {
//       showLoading(context, false);
//     }
//   }

//   Future<void> _saveCardToGalleryiOS() async {
//     try {
//       showLoading(context, true);

//       final Uint8List bytes = await _captureCard();

//       await PhotoSaver.saveImage(bytes);

//       SnackbarHelper.show(context, 'Bukti transaksi berhasil disimpan');
//     } catch (e) {
//       setError(context, e.toString());
//     } finally {
//       showLoading(context, false);
//     }
//   }
// }
