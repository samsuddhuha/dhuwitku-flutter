import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/component/navbar/navbar.dart';
import 'package:dhuwitku/feature/login/forgot_password_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassowordPage extends StatelessWidget {
  const ForgotPassowordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordVm(context),
      child: Consumer<ForgotPasswordVm>(
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
                backgroundColor: Colors.white,
                appBar: Navbar(title: 'Lupa Kata Sandi'),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputField(
                          title: "Email",
                          hintText: "Masukkan email kamu",
                          controller: vm.emailController,
                          errorText: vm.emailError,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (_) => vm.validateEmail(),
                        ),

                        if (vm.isSuccessCheckAccount) ...[
                          const SizedBox(height: 16),
                          InputField(
                            title: "Kata Sandi Baru",
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
                        ],

                        const SizedBox(height: 32),
                        PrimaryButton(
                          text: vm.isSuccessCheckAccount
                              ? 'Ubah Kata Sandi'
                              : 'Lanjutkan',
                          isEnabled: true,
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
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
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
