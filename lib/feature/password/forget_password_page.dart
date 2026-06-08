// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/bottomsheet/confirm_bottom_sheet.dart';
// import 'package:inacash_bisnis/component/button/primary_button.dart';
// import 'package:inacash_bisnis/component/field/input_field.dart';
// import 'package:inacash_bisnis/component/navbar/navbar.dart';
// import 'package:inacash_bisnis/core/ui/app_colors.dart';
// import 'package:inacash_bisnis/core/ui/text_app.dart';
// import 'package:inacash_bisnis/feature/password/forget_password_vm.dart';
// import 'package:provider/provider.dart';

// class ForgetPasswordPage extends StatelessWidget {
//   const ForgetPasswordPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ForgetPasswordVm(context),
//       child: Consumer<ForgetPasswordVm>(
//         builder: (context, vm, _) {
//           return PopScope(
//             canPop: true,
//             child: Scaffold(
//               appBar: Navbar(title: "Lupa Kata Sandi"),
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
//                                 title: "Email",
//                                 hintText: "Masukkan email",
//                                 enabled: !vm.isHaveEmail,
//                                 controller: vm.emailController,
//                                 errorText: vm.emailError,
//                                 onChanged: (value) {
//                                   vm.validateEmail();
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                               TextApp.small(
//                                 'Kata sandi baru akan dikirim ke email tersebut. Setelah itu, Anda akan diminta untuk login ulang.',
//                               ),
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
//                   text: "Kirim",
//                   isEnabled: vm.isFormValid,
//                   onPressed: () {
//                     showConfirmBottomSheet(
//                       context: context,
//                       title: 'Apakah Anda yakin ingin melanjutkan?',
//                       message:
//                           'Kata sandi baru akan dikirim ke email Anda. Setelah menerima, silakan login ulang menggunakan kata sandi tersebut.',
//                       positiveText: 'Kirim',
//                       onPositive: () {
//                         vm.resetPassword();
//                       },
//                       negativeText: 'Batal',
//                     );
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
