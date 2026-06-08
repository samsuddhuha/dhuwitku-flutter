// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/component/bottomsheet/select_bottom_sheet.dart';
// import 'package:inacash_ewallet/component/button/primary_button.dart';
// import 'package:inacash_ewallet/component/divider/divider_app.dart';
// import 'package:inacash_ewallet/component/field/input_field.dart';
// import 'package:inacash_ewallet/component/navbar/navbar.dart';
// import 'package:inacash_ewallet/core/ui/app_colors.dart';
// import 'package:inacash_ewallet/core/ui/app_images.dart';
// import 'package:inacash_ewallet/core/ui/text_app.dart';
// import 'package:inacash_ewallet/feature/register/register_vm.dart';
// import 'package:inacash_ewallet/util/helper/snackbar.dart';
// import 'package:provider/provider.dart';

// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => RegisterVm(context),
//       child: Consumer<RegisterVm>(
//         builder: (context, vm, _) {
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               extendBodyBehindAppBar: true,
//               extendBody: true,
//               appBar: Navbar(title: ''),
//               body: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(AppImages.bgBlackRed),
//                     fit: BoxFit.cover, // penting biar full layar
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextApp.h3(
//                           'Buat akun Inacash anda',
//                           color: AppColors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         SizedBox(height: 16),
//                         TextApp.xSmall(
//                           'Masukkan email Anda. Kami akan mengirimkan link konfirmasi ke email tersebut',
//                           color: AppColors.white,
//                         ),
//                         SizedBox(height: 16),
//                         InputField(
//                           title: "Nama Lengkap",
//                           hintText: "Masukkan nama lengkap kamu",
//                           controller: vm.nameController,
//                           errorText: vm.nameError,
//                           onChanged: (_) => vm.validateName(),
//                         ),
//                         const SizedBox(height: 16),

//                         InputField(
//                           title: "Email",
//                           hintText: "Masukkan email kamu",
//                           controller: vm.emailController,
//                           errorText: vm.emailError,
//                           keyboardType: TextInputType.emailAddress,
//                           onChanged: (_) => vm.validateEmail(),
//                         ),
//                         const SizedBox(height: 16),

//                         InputField(
//                           title: "Nomor Telepon",
//                           hintText: "Masukkan nomor telepon kamu",
//                           controller: vm.phoneNumberController,
//                           errorText: vm.phoneNumberError,
//                           keyboardType: TextInputType.numberWithOptions(
//                             signed: true,
//                           ),
//                           onChanged: (_) => vm.validatePhone(),
//                         ),
//                         const SizedBox(height: 16),

//                         // ===== DIVIDER FULL WIDTH =====
//                         DividerApp(
//                           size: 8,
//                           lineColor: AppColors.surfaceGrey.withValues(
//                             alpha: 0.2,
//                           ),
//                         ),

//                         const SizedBox(height: 16),
//                         InputField(
//                           title: "Provinsi",
//                           hintText: "Pilih provinsi",
//                           rightIconPath: AppImages.icDropdown,
//                           controller: vm.provinceController,
//                           onTap: () {
//                             showSelectBottomSheet(
//                               context: context,
//                               items: vm.provinces.map((e) => e.name).toList(),
//                               onSelected: (v) => {vm.selectProvince(v)},
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         InputField(
//                           title: "Kota/Kabupaten",
//                           hintText: "Pilih kota/kabupaten",
//                           rightIconPath: AppImages.icDropdown,
//                           controller: vm.cityController,
//                           onTap: () {
//                             if (vm.selectedProvince != null) {
//                               showSelectBottomSheet(
//                                 context: context,
//                                 items: vm.cities.map((e) => e.name).toList(),
//                                 onSelected: (v) => {vm.selectCity(v)},
//                               );
//                             } else {
//                               SnackbarHelper.show(
//                                 context,
//                                 'Pilih provinsi terlebih dahulu',
//                                 duration: Duration(seconds: 2),
//                               );
//                             }
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         InputField(
//                           title: "Kecamatan",
//                           hintText: "Pilih kecamatan",
//                           rightIconPath: AppImages.icDropdown,
//                           controller: vm.districtController,
//                           onTap: () {
//                             if (vm.selectedCity != null) {
//                               showSelectBottomSheet(
//                                 context: context,
//                                 items: vm.districts.map((e) => e.name).toList(),
//                                 onSelected: (v) => {vm.selectDistrict(v)},
//                               );
//                             } else {
//                               SnackbarHelper.show(
//                                 context,
//                                 'Pilih kota/kabupaten terlebih dahulu',
//                                 duration: Duration(seconds: 2),
//                               );
//                             }
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         InputField(
//                           title: "Kelurahan",
//                           hintText: "Pilih kelurahan",
//                           rightIconPath: AppImages.icDropdown,
//                           controller: vm.villageController,
//                           onTap: () {
//                             if (vm.selectedDistrict != null) {
//                               showSelectBottomSheet(
//                                 context: context,
//                                 items: vm.villages.map((e) => e.name).toList(),
//                                 onSelected: (v) => {vm.selectVillage(v)},
//                               );
//                             } else {
//                               SnackbarHelper.show(
//                                 context,
//                                 'Pilih kecamatan terlebih dahulu',
//                                 duration: Duration(seconds: 2),
//                               );
//                             }
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         InputField(
//                           title: "Alamat Lengkap",
//                           hintText: "Masukkan alamat lengkap",
//                           controller: vm.addressController,
//                           errorText: vm.addressError,
//                           onChanged: (_) => vm.validateAddress(),
//                         ),
//                         const SizedBox(height: 16),

//                         DividerApp(
//                           size: 8,
//                           lineColor: AppColors.surfaceGrey.withValues(
//                             alpha: 0.2,
//                           ),
//                         ),

//                         const SizedBox(height: 16),
//                         InputField(
//                           title: "Kata Sandi",
//                           hintText: "Masukkan kata sandi",
//                           controller: vm.passwordController,
//                           errorText: vm.passwordError,
//                           obscureText: true,
//                           onChanged: (_) => vm.validatePassword(),
//                         ),
//                         const SizedBox(height: 16),

//                         InputField(
//                           title: "Konfirmasi Kata Sandi",
//                           hintText: "Masukkan ulang kata sandi",
//                           controller: vm.confirmPasswordController,
//                           errorText: vm.confirmPasswordError,
//                           obscureText: true,
//                           onChanged: (_) => vm.validateConfirmPassword(),
//                         ),
//                         const SizedBox(height: 16),

//                         PrimaryButton(
//                           text: "Lanjutkan",
//                           isEnabled: vm.isFormValid,
//                           onPressed: () {
//                             vm.submit();
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               bottomNavigationBar: Container(
//                 color: Colors.transparent,
//                 padding: EdgeInsets.fromLTRB(
//                   16,
//                   16,
//                   16,
//                   16 + MediaQuery.of(context).padding.bottom,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // SizedBox(height: 16),
//                     // PrimaryButton(
//                     //   text: "Buat Akun",
//                     //   isEnabled: true,
//                     //   onPressed: () {
//                     //     // vm.validateUser();
//                     //     // FocusScope.of(context).unfocus();
//                     //   },
//                     // ),
//                     // SizedBox(height: 16),
//                     // SecondaryButton(
//                     //   text: "Masuk",
//                     //   isEnabled: true,
//                     //   onPressed: () {
//                     //     // vm.validateUser();
//                     //     // FocusScope.of(context).unfocus();
//                     //     showConfirmBottomSheet(
//                     //       context: context,
//                     //       imagePath: AppImages.icCloseCircle,
//                     //       title: 'Informasi akun salah',
//                     //       message:
//                     //           'Data kredensial tersebut salah, Silakan coba lagi.',
//                     //       positiveText: 'Mengerti',
//                     //       // marginBottom: 40,
//                     //       onPositive: () async {
//                     //         // await Session.instance.clearSession();
//                     //         // Navigator.pushReplacement(
//                     //         //   context,
//                     //         //   MaterialPageRoute(builder: (_) => LoginPage()),
//                     //         // );
//                     //       },
//                     //     );
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
