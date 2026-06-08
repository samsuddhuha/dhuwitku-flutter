import 'package:dhuwitku/component/bottomsheet/confirm_bottom_sheet.dart';
import 'package:dhuwitku/component/button/google_button.dart';
import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/divider/divider_app.dart';
import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/component/navbar/navbar.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginVm(context),
      child: Consumer<LoginVm>(
        builder: (context, vm, _) {
          return PopScope(
            canPop: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                extendBodyBehindAppBar: true,
                extendBody: true,
                appBar: Navbar(title: ''),
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.bgBlackRed),
                      fit: BoxFit.cover, // penting biar full layar
                    ),
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextApp.h3(
                            'Selamat datang kembali',
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 16),
                          TextApp.xSmall(
                            'Masukkan email yang terhubung dengan akun Inacash Anda',
                            color: AppColors.white,
                          ),
                          SizedBox(height: 16),

                          // Row(
                          //   children: [
                          //     SizedBox(
                          //       width: 90,
                          //       child: InputField(
                          //         enabled: false,
                          //         title: '',
                          //         hintText: '+62',
                          //         controller: vm.emailController,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     SizedBox(width: 8),
                          //     Expanded(
                          //       child: InputField(
                          //         title: '',
                          //         hintText: 'Masukkan nomor telepon',
                          //         controller: vm.emailController,
                          //         fontSize: 14,
                          //         keyboardType: TextInputType.phone,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          InputField(
                            title: "Email",
                            hintText: "Masukkan email kamu",
                            controller: vm.emailController,
                            errorText: vm.emailError,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (_) => vm.validateEmail(),
                          ),
                          const SizedBox(height: 16),

                          InputField(
                            title: "Kata Sandi",
                            hintText: "Masukkan kata sandi",
                            controller: vm.passwordController,
                            errorText: vm.passwordError,
                            obscureText: true,
                            onChanged: (_) => vm.validatePassword(),
                          ),
                          SizedBox(height: 32),
                          PrimaryButton(
                            text: "Lanjutkan",
                            isEnabled: vm.isFormValid(),
                            onPressed: () {
                              vm.validateUser();
                            },
                          ),
                          SizedBox(height: 16),
                          // DividerApp(centerText: 'Belum punya akun?'),
                          // SizedBox(height: 16),
                          // SecondaryButton(
                          //   text: "Buat Akun",
                          //   isEnabled: true,
                          //   onPressed: () {
                          //     showConfirmBottomSheet(
                          //       context: context,
                          //       imagePath: AppImages.icCloseCircle,
                          //       title: 'Informasi akun salah',
                          //       message:
                          //           'Data kredensial tersebut salah, Silakan coba lagi.',
                          //       positiveText: 'Mengerti',
                          //       // marginBottom: 40,
                          //       onPositive: () async {
                          //         // await Session.instance.clearSession();
                          //         // Navigator.pushReplacement(
                          //         //   context,
                          //         //   MaterialPageRoute(builder: (_) => LoginPage()),
                          //         // );
                          //       },
                          //     );
                          //   },
                          // ),
                          DividerApp(centerText: 'atau'),
                          SizedBox(height: 16),
                          GoogleButton(
                            isEnabled: true,
                            onPressed: () {
                              showConfirmBottomSheet(
                                context: context,
                                imagePath: AppImages.icCloseCircle,
                                title: 'Informasi akun salah',
                                message:
                                    'Data kredensial tersebut salah, Silakan coba lagi.',
                                positiveText: 'Mengerti',
                                // marginBottom: 40,
                                onPositive: () async {
                                  // await Session.instance.clearSession();
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(builder: (_) => LoginPage()),
                                  // );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    16 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(height: 16),
                      // PrimaryButton(
                      //   text: "Buat Akun",
                      //   isEnabled: true,
                      //   onPressed: () {
                      //     // vm.validateUser();
                      //     // FocusScope.of(context).unfocus();
                      //   },
                      // ),
                      // SizedBox(height: 16),
                      // SecondaryButton(
                      //   text: "Masuk",
                      //   isEnabled: true,
                      //   onPressed: () {
                      //     // vm.validateUser();
                      //     // FocusScope.of(context).unfocus();
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
