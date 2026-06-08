// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/button/primary_button.dart';
// import 'package:inacash_bisnis/component/field/input_field.dart';
// import 'package:inacash_bisnis/component/navbar/navbar.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/feature/password/edit_password_vm.dart';
// import 'package:provider/provider.dart';

// class EditPasswordPage extends StatelessWidget {
//   const EditPasswordPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => EditPasswordVm(context),
//       child: Consumer<EditPasswordVm>(
//         builder: (context, vm, _) {
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               appBar: Navbar(title: "Ubah Kata Sandi"),
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
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 24),

//                               InputField(
//                                 title: "Kata Sandi Lama",
//                                 hintText: "Masukkan kata sandi lama",
//                                 controller: vm.oldPasswordController,
//                                 errorText: vm.oldPasswordError,
//                                 onChanged: (value) {
//                                   vm.validateOldPassword();
//                                 },
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Kata Sandi Baru",
//                                 hintText: "Masukkan kata sandi baru",
//                                 controller: vm.newPasswordController,
//                                 errorText: vm.newPasswordError,
//                                 onChanged: (value) {
//                                   vm.validateNewPassword();
//                                 },
//                               ),
//                               const SizedBox(height: 16),

//                               InputField(
//                                 title: "Konfirmasi Kata Sandi",
//                                 hintText: "Masukkan konfirmasi kata sandi",
//                                 controller: vm.confirmPasswordController,
//                                 errorText: vm.confirmPasswordError,
//                                 onChanged: (value) {
//                                   vm.validateConfirmPassword();
//                                 },
//                               ),
//                               const SizedBox(height: 24),
//                             ],
//                           ),
//                         ),
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
//                 child: PrimaryButton(
//                   text: "Ubah Kata Sandi",
//                   isEnabled: vm.isFormValid,
//                   onPressed: () {
//                     vm.submit();
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
