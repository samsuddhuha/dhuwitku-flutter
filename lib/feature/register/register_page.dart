import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/component/navbar/navbar.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/register/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterVm(context),
      child: Consumer<RegisterVm>(
        builder: (context, vm, _) {
          return PopScope(
            canPop: true,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: Colors.white,
              appBar: Navbar(title: ''),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextApp.h2(
                        'Buat akun Dhuwitku anda',
                        color: AppColors.tundora,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 16),
                      TextApp.small(
                        'Buat akun Dhuwitku untuk mulai pencatatan keuangan.',
                        color: AppColors.darkGrey,
                      ),
                      SizedBox(height: 16),
                      InputField(
                        title: "Nama Lengkap",
                        hintText: "Masukkan nama lengkap kamu",
                        controller: vm.nameController,
                        errorText: vm.nameError,
                        onChanged: (_) => vm.validateName(),
                      ),
                      const SizedBox(height: 16),

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
                      const SizedBox(height: 16),

                      InputField(
                        title: "Konfirmasi Kata Sandi",
                        hintText: "Masukkan ulang kata sandi",
                        controller: vm.confirmPasswordController,
                        errorText: vm.confirmPasswordError,
                        obscureText: true,
                        onChanged: (_) => vm.validateConfirmPassword(),
                      ),
                      const SizedBox(height: 32),

                      PrimaryButton(
                        text: "Daftar",
                        isEnabled: vm.isFormValid,
                        onPressed: () {
                          vm.submit();
                        },
                      ),
                    ],
                  ),
                ),
              ) /*  */,
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
