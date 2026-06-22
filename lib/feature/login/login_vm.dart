import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/core/session/session.dart';
import 'package:dhuwitku/feature/home/home_page.dart';
import 'package:dhuwitku/feature/main/main_tab_page.dart';
import 'package:dhuwitku/network/remotedata/auth/auth_remote_data.dart';
import 'package:flutter/material.dart';

class LoginVm extends BaseVm {
  final BuildContext context;
  final AuthRemoteData _remote = AuthRemoteData();

  LoginVm(this.context) {
    // fillDemoData();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  String? emailError;
  String? passwordError;
  String? fcmtoken;

  void fillDemoData() {
    emailController.text = "samsuddhuhaa@gmail.com";
    passwordController.text = "cobalagi";
    notifyListeners();
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  bool validateEmail() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError = "Email tidak boleh kosong";
    } else if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
      emailError = "Format email tidak valid";
    } else {
      emailError = null;
    }

    notifyListeners();
    return emailError == null;
  }

  // 🔹 Validasi Password
  bool validatePassword() {
    final password = passwordController.text.trim();

    if (password.isEmpty) {
      passwordError = "Kata sandi tidak boleh kosong";
    } else {
      passwordError = null;
    }

    notifyListeners();
    return passwordError == null;
  }

  bool isFormValid() {
    return emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
  }

  Future<void> login() async {
    try {
      showLoading(context, true);
      final response = await _remote.login(
        email: emailController.text.trim(),
        password: passwordController.text,
        fcm: fcmtoken ?? '',
      );

      final data = response['data'] as Map<String, dynamic>;
      final token = response['session'] as String;

      await Session.instance.createSession(token: token, user: data);

      if (!context.mounted) return;
      showLoading(context, false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const MainTabPage()),
      // );
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
