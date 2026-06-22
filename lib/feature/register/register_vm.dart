import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/network/remotedata/auth/auth_remote_data.dart';
import 'package:dhuwitku/util/helper/snackbar_helper.dart';
import 'package:flutter/material.dart';

class RegisterVm extends BaseVm {
  final BuildContext context;
  final AuthRemoteData _remote = AuthRemoteData();

  RegisterVm(this.context) {
    fillDemoData();
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  void fillDemoData() {
    nameController.text = "Member";
    emailController.text = "member@gmail.com";
    notifyListeners();
  }

  bool validateName() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      nameError = "Nama tidak boleh kosong";
    } else {
      nameError = null;
    }

    notifyListeners();
    return nameError == null;
  }

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
      passwordError = "Kata sandi tidak boleh kosong";
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
    if (confirmPasswordController.text.trim() !=
        passwordController.text.trim()) {
      confirmPasswordError = "Konfirmasi password harus sama";
      passwordError = "Konfirmasi password harus sama";
      notifyListeners();
    } else {
      submitRegister();
    }
  }

  bool get isFormValid {
    return nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  Future<void> submitRegister() async {
    try {
      showLoading(context, true);
      final response = await _remote.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final data = response['data'] as Map<String, dynamic>;

      if (!context.mounted) return;
      showLoading(context, false);
      SnackbarHelper.show(
        context,
        'Pendaftaran Akun Berhasil, Silahkan Login.',
      );
      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
