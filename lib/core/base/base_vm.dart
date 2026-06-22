import 'package:dhuwitku/component/bottomsheet/confirm_bottom_sheet.dart';
import 'package:dhuwitku/component/modal/loading_modal.dart';
import 'package:dhuwitku/util/helper/snackbar_helper.dart';
import 'package:flutter/material.dart';

class BaseVm extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String? get errorMessage => _errorMessage;

  void showLoading(BuildContext context, bool value) {
    _isLoading = value;
    notifyListeners();

    if (value) {
      LoadingModal.show(context);
    } else {
      LoadingModal.hide();
    }
  }

  void setError(BuildContext context, String? message) {
    _isError = message != null;
    _errorMessage = message;

    final isSessionError =
        (message ?? '').contains("Unauthenticated.") ||
        (message ?? '').contains("Invalid key supplied");

    if (isSessionError) {
      // final session = Session.instance;

      // if (session.isSessionExpiredSheetShown) return;

      // session.markSessionExpiredSheetShown();

      showConfirmBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: false,
        title: 'Sesi Anda telah habis',
        message: 'Mohon login ulang untuk melanjutkan.',
        positiveText: 'Login Ulang',
        marginBottom: 40,
        onPositive: () async {
          // await Session.instance.clearSession();
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (_) => LoginPage()),
          // );
        },
      );
    } else {
      notifyListeners();
      if (message != null) {
        SnackbarHelper.show(
          context,
          message,
        );
      }
    }
  }

  void resetState() {
    _isLoading = false;
    _isError = false;
    _errorMessage = null;
    // Session.instance.resetSessionExpiredSheet();
    notifyListeners();
  }
}
