// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/bottomsheet/select_bottom_sheet.dart';
// import 'package:inacash_bisnis/component/button/primary_button.dart';
// import 'package:inacash_bisnis/component/divider/divider_app.dart';
// import 'package:inacash_bisnis/component/field/input_field.dart';
// import 'package:inacash_bisnis/component/image/image_upload_box.dart';
// import 'package:inacash_bisnis/component/navbar/navbar.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/core/ui/app_images.dart';
// import 'package:inacash_bisnis/core/ui/text_app.dart';
// import 'package:inacash_bisnis/feature/camera/camera_page.dart';
// import 'package:inacash_bisnis/feature/register/register_merchant_vm.dart';
// import 'package:inacash_bisnis/util/helper/snackbar.dart';
// import 'package:provider/provider.dart';

// class RegisterMerchantPage extends StatelessWidget {
//   final bool isCompany;
//   const RegisterMerchantPage({super.key, required this.isCompany});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => RegisterMerchantVm(context, isCompany),
//       child: Consumer<RegisterMerchantVm>(
//         builder: (context, vm, _) {
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               appBar: Navbar(title: "Daftar Merchant"),
//               backgroundColor: AppColors.primary,
//               body: SafeArea(
//                 child: Container(
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(32),
//                       topRight: Radius.circular(32),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 8),
//                               InputField(
//                                 title: "Nama Merchant",
//                                 hintText: "Masukkan nama merchant",
//                                 controller: vm.merchantNameController,
//                                 errorText: vm.merchantNameError,
//                                 onChanged: (_) => vm.validateMerchantName(),
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Kriteria Usaha",
//                                 hintText: "Pilih kriteria usaha",
//                                 rightIconPath: AppImages.icDropdown,
//                                 controller: vm.criteriaController,
//                                 onTap: () => {
//                                   showSelectBottomSheet(
//                                     context: context,
//                                     items: vm.listCriteria,
//                                     onSelected: (v) => {vm.selectCriteria(v)},
//                                   ),
//                                 },
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title:
//                                     "NPWP${vm.isCompany ? '' : ' (Opsional)'}",
//                                 hintText: "Masukkan npwp",
//                                 controller: vm.npwpController,
//                                 errorText: vm.npwpError,
//                                 keyboardType: TextInputType.numberWithOptions(
//                                   signed: true,
//                                   decimal: true,
//                                 ),
//                                 onChanged: (_) => vm.validateNpwp(),
//                               ),
//                             ],
//                           ),
//                         ),

//                         DividerApp(size: 8),

//                         Padding(
//                           padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//                           child: Column(
//                             children: [
//                               InputField(
//                                 title: "Nomor KTP",
//                                 hintText: "Masukkan nomor ktp",
//                                 controller: vm.nikController,
//                                 errorText: vm.nikError,
//                                 keyboardType: TextInputType.numberWithOptions(
//                                   signed: true,
//                                   decimal: true,
//                                 ),
//                                 onChanged: (_) => vm.validateNik(),
//                               ),
//                               const SizedBox(height: 16),
//                               ImageUploadBox(
//                                 title: 'Foto KTP',
//                                 image: vm.idCardImage,
//                                 height: 220,
//                                 onTap: () async {
//                                   if (await vm.requestCameraPermission()) {
//                                     if (!context.mounted) return;
//                                     final result = await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) =>
//                                             CameraPage(isCaptureIdCard: true),
//                                       ),
//                                     );

//                                     if (result != null && context.mounted) {
//                                       vm.updateIdCardImage(result);
//                                     }
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                             ],
//                           ),
//                         ),

//                         // ===== DIVIDER FULL WIDTH =====
//                         DividerApp(size: 8),

//                         // ===== SECTION BAWAH (PAKAI PADDING) =====
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               InputField(
//                                 title: "Provinsi",
//                                 hintText: "Pilih provinsi",
//                                 rightIconPath: AppImages.icDropdown,
//                                 controller: vm.provinceController,
//                                 onTap: () {
//                                   showSelectBottomSheet(
//                                     context: context,
//                                     items: vm.provinces
//                                         .map((e) => e.name)
//                                         .toList(),
//                                     onSelected: (v) => {vm.selectProvince(v)},
//                                   );
//                                 },
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Kota/Kabupaten",
//                                 hintText: "Pilih kota/kabupaten",
//                                 rightIconPath: AppImages.icDropdown,
//                                 controller: vm.cityController,
//                                 onTap: () {
//                                   if (vm.selectedProvince != null) {
//                                     showSelectBottomSheet(
//                                       context: context,
//                                       items: vm.cities
//                                           .map((e) => e.name)
//                                           .toList(),
//                                       onSelected: (v) => {vm.selectCity(v)},
//                                     );
//                                   } else {
//                                     SnackbarHelper.show(
//                                       context,
//                                       'Pilih provinsi terlebih dahulu',
//                                       duration: Duration(seconds: 2),
//                                     );
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Kecamatan",
//                                 hintText: "Pilih kecamatan",
//                                 rightIconPath: AppImages.icDropdown,
//                                 controller: vm.districtController,
//                                 onTap: () {
//                                   if (vm.selectedCity != null) {
//                                     showSelectBottomSheet(
//                                       context: context,
//                                       items: vm.districts
//                                           .map((e) => e.name)
//                                           .toList(),
//                                       onSelected: (v) => {vm.selectDistrict(v)},
//                                     );
//                                   } else {
//                                     SnackbarHelper.show(
//                                       context,
//                                       'Pilih kota/kabupaten terlebih dahulu',
//                                       duration: Duration(seconds: 2),
//                                     );
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Alamat Lengkap",
//                                 hintText: "Masukkan alamat lengkap",
//                                 controller: vm.addressController,
//                                 errorText: vm.addressError,
//                                 onChanged: (_) => vm.validateAddress(),
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Kode Pos",
//                                 hintText: "Masukkan kode pos",
//                                 controller: vm.postalCodeController,
//                                 errorText: vm.postalCodeError,
//                                 onChanged: (_) => vm.validatePostalCode(),
//                               ),
//                             ],
//                           ),
//                         ),

//                         DividerApp(size: 8),

//                         Padding(
//                           padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//                           child: Column(
//                             children: [
//                               ImageUploadBox(
//                                 title: 'Foto Bagian Depan Merchant',
//                                 image: vm.frontMerchantImage,
//                                 height: 260,
//                                 boxFit: BoxFit.fitHeight,
//                                 onTap: () async {
//                                   if (await vm.requestCameraPermission()) {
//                                     if (!context.mounted) return;
//                                     final result = await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => CameraPage(),
//                                       ),
//                                     );

//                                     if (result != null && context.mounted) {
//                                       vm.updateFrontMerchantImage(result);
//                                     }
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                               ImageUploadBox(
//                                 title: 'Foto Bagian Dalam Merchant',
//                                 image: vm.insideMerchantImage,
//                                 height: 260,
//                                 boxFit: BoxFit.fitHeight,
//                                 onTap: () async {
//                                   if (await vm.requestCameraPermission()) {
//                                     if (!context.mounted) return;
//                                     final result = await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => CameraPage(),
//                                       ),
//                                     );

//                                     if (result != null && context.mounted) {
//                                       vm.updateInsideMerchantImage(result);
//                                     }
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                               ImageUploadBox(
//                                 title: 'Foto Kasir Merchant',
//                                 image: vm.cashierImage,
//                                 height: 260,
//                                 boxFit: BoxFit.fitHeight,
//                                 onTap: () async {
//                                   if (await vm.requestCameraPermission()) {
//                                     if (!context.mounted) return;
//                                     final result = await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => CameraPage(),
//                                       ),
//                                     );

//                                     if (result != null && context.mounted) {
//                                       vm.updateCashierImage(result);
//                                     }
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                             ],
//                           ),
//                         ),

//                         DividerApp(size: 8),

//                         Padding(
//                           padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//                           child: Column(
//                             children: [
//                               TextApp.small(
//                                 'Rekening bank akan digunakan sebagai rekening tujuan pencairan dana Anda',
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Bank",
//                                 hintText: "Pilih bank",
//                                 rightIconPath: AppImages.icDropdown,
//                                 controller: vm.bankController,
//                                 onTap: () {
//                                   showSelectBottomSheet(
//                                     context: context,
//                                     items: vm.banks.map((e) => e.name).toList(),
//                                     onSelected: (v) => {vm.selectbank(v)},
//                                   );
//                                 },
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Nomor rekening",
//                                 hintText: "Masukkan nomor rekeneing",
//                                 controller: vm.accountNumberController,
//                                 errorText: vm.accountNumberError,
//                                 keyboardType: TextInputType.numberWithOptions(
//                                   signed: true,
//                                   decimal: true,
//                                 ),
//                                 onChanged: (_) => vm.validateAccountNumber(),
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Nama Pemilik Rekening",
//                                 hintText: "Masukkan nama pemilik rekening",
//                                 controller: vm.accountNameController,
//                                 errorText: vm.accountNameError,
//                                 onChanged: (_) => vm.validateAccountName(),
//                               ),
//                               const SizedBox(height: 16),
//                             ],
//                           ),
//                         ),

//                         Padding(
//                           padding: EdgeInsets.fromLTRB(
//                             16,
//                             16,
//                             16,
//                             16 + MediaQuery.of(context).padding.bottom,
//                           ),
//                           child: Column(
//                             children: [
//                               PrimaryButton(
//                                 text: "Daftar",
//                                 isEnabled: vm.isFormValid,
//                                 onPressed: () {
//                                   vm.submit();
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               bottomNavigationBar: Container(
//                 color: AppColors.white,
//                 padding: EdgeInsets.all(0),
//                 child: SizedBox(),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
