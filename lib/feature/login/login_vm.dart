import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/core/session/session.dart';
import 'package:dhuwitku/network/remotedata/auth/auth_remote_data.dart';
import 'package:dhuwitku/util/helper/snackbar.dart';
import 'package:flutter/material.dart';

class LoginVm extends BaseVm {
  final BuildContext context;
  final AuthRemoteData _remote = AuthRemoteData();

  LoginVm(this.context) {
    // fillDemoData();
    // getRememberMe();
    // getToken();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  String? emailError;
  String? passwordError;
  String? fcmtoken;

  void fillDemoData() {
    // emailController.text = "suddhuha@gmail.com";
    // passwordController.text = "qwerty1234";
    // emailController.text = "member@gmail.com";
    // passwordController.text = "0mIht7IJhuBM";
    // emailController.text = "cmi@bayardigital.com";
    // passwordController.text = "namasaya2";
    notifyListeners();
  }

  // Future<void> getRememberMe() async {
  //   final result = await Session.instance.getRememberMe();
  //   if (result != null) {
  //     rememberMe = true;
  //     emailController.text = result;
  //   }
  //   notifyListeners();
  // }

  // Future<void> getToken() async {
  //   fcmtoken = await FcmService.getTokenAsync();
  //   notifyListeners();
  // }

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

  Future<void> validateUser() async {
    try {
      showLoading(context, true);

      final isFound = await _remote.validateUser(emailController.text.trim());

      if (isFound) {
        if (!context.mounted) return;
        SnackbarHelper.show(context, "Email/Password salah.");
        showLoading(context, false);
      } else {
        login();
      }
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> login() async {
    try {
      final response = await _remote.login(
        email: emailController.text.trim(),
        password: passwordController.text,
        fcm: fcmtoken ?? '',
      );

      if (!context.mounted) return;
      showLoading(context, false);

      final Map<String, dynamic> json = response;

      final data = json['data'] as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = data['user'] as Map<String, dynamic>;
      // final List merchants = user['user_qrises'] ?? [];

      await Session.instance.createSession(token: token, user: user);

      // if (rememberMe) {
      //   await Session.instance.saveRememberMe(emailController.text.trim());
      // } else {
      //   await Session.instance.clearRememberMe();
      // }

      // if (!context.mounted) return;
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
