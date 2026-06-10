import 'dart:convert';

import 'package:dhuwitku/network/remotedata/auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static final Session instance = Session._internal();
  Session._internal();

  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyToken = 'token';
  static const _keyUser = 'user';
  // static const _keyMerchant = 'merchant';
  // static const _keyMerchantList = 'merchant_list';
  // static const _keyIsAllMerchantSelected = 'is_all_merchant_selected';
  // static const _keyIsReloadData = 'is_reload_data';
  // static const _keyIsReloadMerchant = 'is_reload_merchant';
  // static const _keyIsRedirectToQrisPage = 'is_redirect_to_qris_page';
  // static const _keyIsQrisStatic = 'is_qris_static';
  // static const _keyIsLoadPinStatus = 'is_load_pin_status';
  // static const _keySelectedIndexBottomNavbar = 'selected_index_bottom_navbar';
  // static const _keySelectedIndexTabReport = 'selected_index_tab_report';
  // static const _keyRememberMe = 'remember_me';

  // ========================
  // In-memory cache
  // ========================
  String? _token;
  String? get token => _token;

  bool _isSessionExpiredSheetShown = false;
  bool get isSessionExpiredSheetShown => _isSessionExpiredSheetShown;

  // ========================
  // Auth Session
  // ========================

  /// 🔐 Simpan session login
  Future<void> createSession({
    required String token,
    required Map<String, dynamic> user,
  }) async {
    _token = token;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyUser, jsonEncode(user));
  }

  /// 🔑 Load token ke memory (dipakai interceptor)
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_keyToken);
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user));
  }

  /// 🧑 Ambil user
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyUser);
    if (data == null || data.isEmpty) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  // /// ✅ Cek login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  void markSessionExpiredSheetShown() {
    _isSessionExpiredSheetShown = true;
  }

  void resetSessionExpiredSheet() {
    _isSessionExpiredSheetShown = false;
  }

  // ========================
  // Logout
  // ========================

  /// 🚪 Logout & clear session
  Future<void> clearSession() async {
    _token = null;
    // _isReloadData = false;
    resetSessionExpiredSheet();

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUser);
    // await prefs.remove(_keyMerchant);
    // await prefs.remove(_keyMerchantList);
    // await prefs.remove(_keyIsAllMerchantSelected);
    // await prefs.remove(_keyIsReloadData);
    // await prefs.remove(_keyIsReloadMerchant);
    // await prefs.remove(_keyIsRedirectToQrisPage);
    // await prefs.remove(_keyIsQrisStatic);
    // await prefs.remove(_keyIsLoadPinStatus);
    // await prefs.remove(_keySelectedIndexBottomNavbar);
    // await prefs.remove(_keySelectedIndexTabReport);
  }

  // Future<void> saveRememberMe(String value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_keyRememberMe, value);
  // }

  // Future<String?> getRememberMe() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_keyRememberMe);
  // }

  // Future<void> clearRememberMe() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_keyRememberMe);
  // }
}
