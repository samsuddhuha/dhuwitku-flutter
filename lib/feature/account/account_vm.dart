// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/component/bottomsheet/confirm_bottom_sheet.dart';
// import 'package:inacash_ewallet/core/base/base_vm.dart';
// import 'package:inacash_ewallet/core/session/session.dart';
// import 'package:inacash_ewallet/feature/login/login_page.dart';
// import 'package:inacash_ewallet/feature/onboarding/onboarding_page.dart';

// class AccountVm extends BaseVm {
//   final BuildContext context;

//   // final UserRemoteData _userRemoteData = UserRemoteData();

//   // UserModel? user;
//   // MerchantModel? merchant;
//   // bool? isAllMerchantSelected;
//   // List<MerchantModel>? merchants;
//   // bool? isPinExist;

//   bool isMerchantNonActive = false;

//   AccountVm(this.context) {
//     // getPinStatus();
//     // getUser();
//     // getMerchant();
//   }

//   // Future<void> getUser() async {
//   //   user = await Session.instance.getUser();
//   //   notifyListeners();
//   // }

//   // Future<void> getMerchant() async {
//   //   merchant = await Session.instance.getMerchant();
//   //   await getIsAllMerchantSelected();
//   //   await getListMerchant();
//   //   checkMerchantStatus();
//   //   notifyListeners();
//   // }

//   // Future<void> getIsAllMerchantSelected() async {
//   //   isAllMerchantSelected = await Session.instance.isAllMerchantSelected();
//   // }

//   // Future<void> getListMerchant() async {
//   //   merchants = await Session.instance.getListMerchant();
//   // }

//   // Future<void> checkMerchantStatus() async {
//   //   final isAllSelected =
//   //       await Session.instance.isAllMerchantSelected() ?? false;

//   //   if (isAllSelected) {
//   //     isMerchantNonActive = false;
//   //   } else {
//   //     isMerchantNonActive =
//   //         merchant?.nmid == null ||
//   //         merchant!.nmid!.isEmpty ||
//   //         merchant?.raw == null ||
//   //         merchant!.raw!.isEmpty;
//   //   }

//   //   notifyListeners();
//   // }

//   // Future<void> getPinStatus() async {
//   //   if (isPinExist == true) {
//   //     return;
//   //   }
//   //   try {
//   //     final response = await _userRemoteData.getPinStatus();
//   //     final data = response['data'] as Map<String, dynamic>;
//   //     isPinExist = data['status'] as bool?;
//   //     notifyListeners();
//   //   } catch (e) {
//   //     if (!context.mounted) return;
//   //     setError(context, e.toString().replaceFirst('Exception: ', ''));
//   //   }
//   // }

//   // Future<void> deleteAccount() async {
//   //   try {
//   //     showLoading(context, true);
//   //     if (user == null) return;

//   //     await _userRemoteData.deleteAccount(
//   //       id: user?.id ?? 0,
//   //       name: user?.fullname ?? '',
//   //       email: user?.email ?? '',
//   //     );

//   //     SnackbarHelper.show(context, "Hapus akun berhasil");

//   //     if (!context.mounted) return;
//   //     showLoading(context, false);
//   //     await Session.instance.clearSession();
//   //     if (!context.mounted) return;
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (_) => LoginPage()),
//   //     );
//   //   } catch (e) {
//   //     if (!context.mounted) return;
//   //     showLoading(context, false);
//   //     SnackbarHelper.show(
//   //       context,
//   //       "Hapus akun gagal, hubungi customer service untuk mengkonfirmasi hapus akun",
//   //     );
//   //   }
//   // }

//   void logout() {
//     showConfirmBottomSheet(
//       context: context,
//       title: 'Yakin mau keluar dari Inacash?',
//       message: 'Anda akan keluar dari akun ini. Yakin ingin melanjutkan?',
//       negativeText: 'Batal',
//       positiveText: 'Keluar',
//       marginBottom: 40,
//       onPositive: () async {
//         await Session.instance.clearSession();
//         if (!context.mounted) return;
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => OnboardingPage(isToLogin: true)),
//         );
//       },
//     );
//   }
// }
