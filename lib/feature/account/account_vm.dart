import 'package:dhuwitku/component/bottomsheet/confirm_bottom_sheet.dart';
import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/core/session/session.dart';
import 'package:dhuwitku/feature/login/login_page.dart';
import 'package:dhuwitku/network/remotedata/auth/model/user_model.dart';
import 'package:flutter/material.dart';

class AccountVm extends BaseVm {
  final BuildContext context;

  // final UserRemoteData _userRemoteData = UserRemoteData();

  UserModel? user;
  // MerchantModel? merchant;
  // bool? isAllMerchantSelected;
  // List<MerchantModel>? merchants;
  // bool? isPinExist;

  AccountVm(this.context) {
    // getPinStatus();
    getUser();
    // getMerchant();
  }

  Future<void> getUser() async {
    user = await Session.instance.getUser();
    notifyListeners();
  }

  // Future<void> getMerchant() async {
  //   merchant = await Session.instance.getMerchant();
  //   await getIsAllMerchantSelected();
  //   await getListMerchant();
  //   checkMerchantStatus();
  //   notifyListeners();
  // }

  // Future<void> getIsAllMerchantSelected() async {
  //   isAllMerchantSelected = await Session.instance.isAllMerchantSelected();
  // }

  // Future<void> getListMerchant() async {
  //   merchants = await Session.instance.getListMerchant();
  // }

  // Future<void> checkMerchantStatus() async {
  //   final isAllSelected =
  //       await Session.instance.isAllMerchantSelected() ?? false;

  //   if (isAllSelected) {
  //     isMerchantNonActive = false;
  //   } else {
  //     isMerchantNonActive =
  //         merchant?.nmid == null ||
  //         merchant!.nmid!.isEmpty ||
  //         merchant?.raw == null ||
  //         merchant!.raw!.isEmpty;
  //   }

  //   notifyListeners();
  // }

  // Future<void> getPinStatus() async {
  //   if (isPinExist == true) {
  //     return;
  //   }
  //   try {
  //     final response = await _userRemoteData.getPinStatus();
  //     final data = response['data'] as Map<String, dynamic>;
  //     isPinExist = data['status'] as bool?;
  //     notifyListeners();
  //   } catch (e) {
  //     if (!context.mounted) return;
  //     setError(context, e.toString().replaceFirst('Exception: ', ''));
  //   }
  // }

  // Future<void> deleteAccount() async {
  //   try {
  //     showLoading(context, true);
  //     if (user == null) return;

  //     await _userRemoteData.deleteAccount(
  //       id: user?.id ?? 0,
  //       name: user?.fullname ?? '',
  //       email: user?.email ?? '',
  //     );

  //     SnackbarHelper.show(context, "Hapus akun berhasil");

  //     if (!context.mounted) return;
  //     showLoading(context, false);
  //     await Session.instance.clearSession();
  //     if (!context.mounted) return;
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => LoginPage()),
  //     );
  //   } catch (e) {
  //     if (!context.mounted) return;
  //     showLoading(context, false);
  //     SnackbarHelper.show(
  //       context,
  //       "Hapus akun gagal, hubungi customer service untuk mengkonfirmasi hapus akun",
  //     );
  //   }
  // }

  void logout() {
    showConfirmBottomSheet(
      context: context,
      title: 'Keluar Akun',
      message: 'Anda akan keluar dari akun ini. Yakin ingin melanjutkan?',
      negativeText: 'Batal',
      positiveText: 'Keluar',
      onPositive: () async {
        await Session.instance.clearSession();
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      },
    );
  }
}
