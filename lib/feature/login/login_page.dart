import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/button/secondary_button.dart';
import 'package:dhuwitku/component/button/transparent_button.dart';
import 'package:dhuwitku/component/divider/divider_app.dart';
import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/login/forgot_passoword_page.dart';
import 'package:dhuwitku/feature/login/login_vm.dart';
import 'package:dhuwitku/feature/register/register_page.dart';
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
            canPop: false,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                extendBodyBehindAppBar: true,
                extendBody: true,
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 48),
                        TextApp.h2(
                          'Selamat datang kembali',
                          color: AppColors.tundora,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 16),
                        TextApp.small(
                          'Masukkan email yang terhubung dengan akun Dhuwitku kamu.',
                          color: AppColors.darkGrey,
                        ),
                        SizedBox(height: 16),

                        InputField(
                          title: "Email",
                          hintText: "Masukkan email",
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
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPassowordPage(),
                                ),
                              );
                            },
                            child: TextApp.small(
                              'Lupa Kata Sandi?',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        PrimaryButton(
                          text: "Masuk",
                          isEnabled: vm.isFormValid(),
                          onPressed: () {
                            vm.login();
                          },
                        ),
                        SizedBox(height: 16),
                        // GoogleButton(
                        //   isEnabled: true,
                        //   onPressed: () {
                        //     showConfirmBottomSheet(
                        //       context: context,
                        //       imagePath: AppImages.icCloseCircle,
                        //       title: 'Informasi akun salah',
                        //       message:
                        //           'Data kredensial tersebut salah, Silakan coba lagi.',
                        //       positiveText: 'Mengerti',
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
                        // SizedBox(height: 16),
                        DividerApp(
                          centerText: 'Belum punya akun?',
                          lineColor: AppColors.silver,
                          textColor: AppColors.tundora,
                        ),
                        SizedBox(height: 16),
                        SecondaryButton(
                          text: "Daftar",
                          isEnabled: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => RegisterPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // bottomNavigationBar: Container(
                //   color: Colors.transparent,
                //   padding: EdgeInsets.fromLTRB(
                //     16,
                //     16,
                //     16,
                //     16 + MediaQuery.of(context).padding.bottom,
                //   ),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       // SizedBox(height: 16),
                //       // PrimaryButton(
                //       //   text: "Buat Akun",
                //       //   isEnabled: true,
                //       //   onPressed: () {
                //       //     // vm.validateUser();
                //       //     // FocusScope.of(context).unfocus();
                //       //   },
                //       // ),
                //       // SizedBox(height: 16),
                //       // SecondaryButton(
                //       //   text: "Masuk",
                //       //   isEnabled: true,
                //       //   onPressed: () {
                //       //     // vm.validateUser();
                //       //     // FocusScope.of(context).unfocus();
                //       //   },
                //       // ),
                //     ],
                //   ),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
