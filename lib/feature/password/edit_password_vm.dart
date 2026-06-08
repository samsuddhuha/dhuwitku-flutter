// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/core/base/base_vm.dart';
// import 'package:inacash_bisnis/core/session/session.dart';
// import 'package:inacash_bisnis/feature/login/login_page.dart';
// import 'package:inacash_bisnis/network/remotedata/user/user_remote_data.dart';
// import 'package:inacash_bisnis/util/helper/snackbar.dart';

// class EditPasswordVm extends BaseVm {
//   final BuildContext context;
//   final UserRemoteData _userRemoteData = UserRemoteData();

//   EditPasswordVm(this.context);

//   final oldPasswordController = TextEditingController();
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   String? oldPasswordError;
//   String? newPasswordError;
//   String? confirmPasswordError;

//   Future<void> editPassword() async {
//     try {
//       showLoading(context, true);
//       final response = await _userRemoteData.editPassword(
//         oldPassword: oldPasswordController.text.trim(),
//         newPassword: confirmPasswordController.text.trim(),
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

//   void validateOldPassword() {
//     final password = oldPasswordController.text.trim();

//     if (password.isEmpty) {
//       oldPasswordError = "Kata sandi lama tidak boleh kosong";
//     } else {
//       oldPasswordError = null;
//     }

//     notifyListeners();
//   }

//   void validateNewPassword() {
//     final password = newPasswordController.text.trim();

//     if (password.isEmpty) {
//       newPasswordError = "Kata sandi baru tidak boleh kosong";
//     } else {
//       newPasswordError = null;
//     }
//     if (confirmPasswordController.text.trim() ==
//         newPasswordController.text.trim()) {
//       newPasswordError = null;
//       confirmPasswordError = null;
//     }

//     notifyListeners();
//   }

//   void validateConfirmPassword() {
//     final confirmPassword = confirmPasswordController.text.trim();

//     if (confirmPassword.isEmpty) {
//       confirmPasswordError = "Konfirmasi kata sandi tidak boleh kosong";
//     } else {
//       confirmPasswordError = null;
//     }
//     if (confirmPasswordController.text.trim() ==
//         newPasswordController.text.trim()) {
//       newPasswordError = null;
//       confirmPasswordError = null;
//     }

//     notifyListeners();
//   }

//   void submit() {
//     if (confirmPasswordController.text.trim() !=
//         newPasswordController.text.trim()) {
//       confirmPasswordError = "Konfirmasi password harus sama";
//       newPasswordError = "Konfirmasi password harus sama";
//       notifyListeners();
//     } else {
//       editPassword();
//     }
//   }

//   bool get isFormValid {
//     return oldPasswordError == null &&
//         newPasswordError == null &&
//         confirmPasswordError == null &&
//         oldPasswordController.text.isNotEmpty &&
//         newPasswordController.text.isNotEmpty &&
//         confirmPasswordController.text.isNotEmpty;
//   }
// }
