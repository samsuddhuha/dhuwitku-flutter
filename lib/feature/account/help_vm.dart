// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/core/base/base_vm.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HelpVm extends BaseVm {
//   final BuildContext context;

//   HelpVm(this.context) {
//     getAppVersionWithBuild();
//   }

//   String version = '';

//   Future<void> openWhatsApp(String phone, {String? message}) async {
//     final text = Uri.encodeComponent(message ?? '');
//     final uri = Uri.parse('https://wa.me/$phone?text=$text');

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }

//   Future<void> openEmail(String email, {String? subject, String? body}) async {
//     final uri = Uri(
//       scheme: 'mailto',
//       path: email,
//       queryParameters: {
//         if (subject != null) 'subject': subject,
//         if (body != null) 'body': body,
//       },
//     );

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }

//   Future<void> getAppVersionWithBuild() async {
//     final info = await PackageInfo.fromPlatform();
//     version = '${info.version} (${info.buildNumber})';
//     notifyListeners();
//   }
// }
