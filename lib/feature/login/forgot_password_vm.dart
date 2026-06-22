import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/network/remotedata/auth/auth_remote_data.dart';
import 'package:dhuwitku/util/helper/snackbar_helper.dart';
import 'package:flutter/material.dart';

class ForgotPasswordVm extends BaseVm {
  final BuildContext context;
  final AuthRemoteData _remote = AuthRemoteData();

  ForgotPasswordVm(this.context) {}

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isSuccessCheckAccount = false;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  void validateEmail() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError = "Email tidak boleh kosong";
    } else if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
      emailError = "Format email tidak valid";
    } else {
      emailError = null;
    }

    notifyListeners();
  }

  // 🔹 Validasi Password
  void validatePassword() {
    final password = passwordController.text.trim();
    if (password.isEmpty) {
      passwordError = "Kata sandi baru tidak boleh kosong";
      notifyListeners();
      return;
    } else {
      passwordError = null;
    }
    if (confirmPasswordController.text.trim() ==
        passwordController.text.trim()) {
      passwordError = null;
      confirmPasswordError = null;
    }

    notifyListeners();
  }

  void validateConfirmPassword() {
    final confirmPassword = confirmPasswordController.text.trim();

    if (confirmPassword.isEmpty) {
      confirmPasswordError = "Konfirmasi kata sandi tidak boleh kosong";
      notifyListeners();
      return;
    } else {
      confirmPasswordError = null;
    }
    if (confirmPasswordController.text.trim() ==
        passwordController.text.trim()) {
      passwordError = null;
      confirmPasswordError = null;
    }

    notifyListeners();
  }

  void submit() {
    if (!isSuccessCheckAccount) {
      validateEmail();
      if (emailError != null) {
        return;
      }
      checkAccount();
      return;
    }
    validatePassword();
    validateConfirmPassword();
    if (passwordError != null && confirmPasswordError != null) {
      return;
    }
    if (confirmPasswordController.text.trim() !=
        passwordController.text.trim()) {
      confirmPasswordError = "Konfirmasi password harus sama";
      passwordError = "Konfirmasi password harus sama";
      notifyListeners();
    } else {
      resetPassword();
    }
  }

  Future<void> checkAccount() async {
    try {
      showLoading(context, true);
      final response = await _remote.checkAccount(
        email: emailController.text.trim(),
      );

      final _ = response['data'] as Map<String, dynamic>;

      isSuccessCheckAccount = true;
      if (!context.mounted) return;
      showLoading(context, false);
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> resetPassword() async {
    try {
      showLoading(context, true);
      final _ = await _remote.resetPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (!context.mounted) return;
      showLoading(context, false);
      SnackbarHelper.show(
        context,
        'Kata Sandi Berhasil Diperbarui, Silahkan Login.',
      );
      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
