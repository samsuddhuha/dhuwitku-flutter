// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/core/base/base_vm.dart';
// import 'package:inacash_bisnis/core/session/session.dart';
// import 'package:inacash_bisnis/feature/login/login_page.dart';
// import 'package:inacash_bisnis/network/remotedata/auth/model/user_model.dart';
// import 'package:inacash_bisnis/network/remotedata/user/user_remote_data.dart';
// import 'package:inacash_bisnis/util/helper/snackbar.dart';

// class ForgetPasswordVm extends BaseVm {
//   final BuildContext context;
//   final UserRemoteData _userRemoteData = UserRemoteData();

//   ForgetPasswordVm(this.context) {
//     getUser();
//   }

//   UserModel? user;
//   bool isHaveEmail = false;

//   final emailController = TextEditingController();

//   String? emailError;

//   Future<void> getUser() async {
//     user = await Session.instance.getUser();
//     final email = user?.email ?? '';
//     isHaveEmail = email.isNotEmpty;
//     emailController.text = email;
//     notifyListeners();
//   }

//   Future<void> resetPassword() async {
//     try {
//       showLoading(context, true);
//       final response = await _userRemoteData.resetPassword(
//         email: emailController.text.trim(),
//       );

//       if (!context.mounted) return;
//       showLoading(context, false);
//       SnackbarHelper.show(context, response['message']);

//       await Session.instance.clearSession();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => LoginPage()),
//       );
//     } catch (e) {
//       if (!context.mounted) return;
//       showLoading(context, false);
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }

//   bool validateEmail() {
//     final email = emailController.text.trim();

//     if (email.isEmpty) {
//       emailError = "Email tidak boleh kosong";
//     } else if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
//       emailError = "Format email tidak valid";
//     } else {
//       emailError = null;
//     }

//     notifyListeners();
//     return emailError == null;
//   }

//   bool get isFormValid {
//     return emailError == null && emailController.text.isNotEmpty;
//   }
// }
