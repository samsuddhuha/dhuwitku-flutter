import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';

class RemoteConfigService {
  static final RemoteConfigService instance = RemoteConfigService._();

  RemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setDefaults({
      'welcome_message': 'Hello user!',
      'enable_pinning': true,
    });

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 5),
      ),
    );

    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint("RemoteConfig fetch failed: $e");
    }
  }

  // safe getter
  bool getBoolSafe(String key, {bool fallback = false}) {
    try {
      return _remoteConfig.getBool(key);
    } catch (_) {
      return fallback;
    }
  }

  // feature flags
  String get welcomeMessage => _remoteConfig.getString('welcome_message');

  // 🔐 SECURITY FLAG
  bool get enablePinning => _remoteConfig.getBool('enable_pinning');

  // 🔄 manual emergency refresh
  Future<void> forceRefresh() async {
    try {
      await _remoteConfig.fetch();
      await _remoteConfig.activate();
    } catch (e) {
      debugPrint("RemoteConfig refresh failed: $e");
    }
  }
}
