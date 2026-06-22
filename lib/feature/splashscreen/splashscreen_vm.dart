import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/core/session/session.dart';
import 'package:dhuwitku/feature/home/home_page.dart';
import 'package:dhuwitku/feature/login/login_page.dart';
import 'package:dhuwitku/feature/main/main_tab_page.dart';
import 'package:dhuwitku/network/config/app_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreenVm extends BaseVm {
  final BuildContext context;

  SplashScreenVm(this.context);

  Future<void> init() async {
    await Session.instance.loadToken();
    // await FcmService.init();
    // await RemoteConfigService.instance.forceRefresh();

    AppClient.instance.init();
    if (!kIsWeb) {
      await Future.delayed(const Duration(milliseconds: 1500));
    }

    if (!context.mounted) return;

    final isLoggedIn = await Session.instance.isLoggedIn();

    if (isLoggedIn && Session.instance.token != null) {
      goToHome();
    } else {
      goToLogin();
    }
  }

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  void goToHome() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => const MainTabPage()),
    // );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }
}
