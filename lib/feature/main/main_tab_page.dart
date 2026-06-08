// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:inacash_ewallet/core/ui/app_colors.dart';
// import 'package:inacash_ewallet/core/ui/app_images.dart';
// import 'package:inacash_ewallet/core/ui/text_app.dart';
// import 'package:inacash_ewallet/feature/home/home_page.dart';
// import 'package:inacash_ewallet/feature/qris/scan_qris_page.dart';
// import 'package:inacash_ewallet/feature/report/report_page.dart';
// import 'package:inacash_ewallet/main.dart';

// class MainTabPage extends StatefulWidget {
//   const MainTabPage({super.key});

//   @override
//   State<MainTabPage> createState() => _MainTabPageState();
// }

// class _MainTabPageState extends State<MainTabPage> with RouteAware {
//   int _currentIndex = 0;
//   // MerchantModel? merchant;
//   bool isAllMerchantSelected = false;
//   bool isRedirectToQrisPage = false;
//   bool isQrisStatic = false;

//   final List<Widget> _pages = const [
//     HomePage(),
//     SizedBox(), // index 2 adalah tombol tengah
//     ReportPage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // _loadMerchantSelection();
//     // _loadSelectedIndexBottomNavbar();
//     // _getMerchant();
//   }

//   void _onTabTapped(int index) {
//     if (index == 1) {
//       // tombol tengah
//       return;
//     }

//     setState(() => _currentIndex = index);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final route = ModalRoute.of(context);
//     if (route is PageRoute) {
//       routeObserver.subscribe(this, route);
//     }
//   }

//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }

//   @override
//   Future<void> didPopNext() async {
//     // await _loadMerchantSelection();
//     // await _loadIsRedirectToQrisPage();
//     // await _loadIsQrisStatic();
//     // await _getMerchant();

//     // if (isRedirectToQrisPage) {
//     //   await Session.instance.setRedirectToQrisPage(false);
//     //   await Session.instance.setQrisStatic(false);
//     //   Navigator.push(
//     //     context,
//     //     MaterialPageRoute(builder: (_) => QrisPage(isStatic: isQrisStatic)),
//     //   );
//     // }
//   }

//   // Future<void> _getMerchant() async {
//   //   final getMerchant = await Session.instance.getMerchant();
//   //   setState(() {
//   //     merchant = getMerchant;
//   //   });
//   // }

//   // Future<void> _loadSelectedIndexBottomNavbar() async {
//   //   final result = await Session.instance.getSelectedIndexBottomNavbar();
//   //   await Session.instance.setSelectedIndexBottomNavbar(0);
//   //   setState(() {
//   //     _currentIndex = result ?? 0;
//   //   });
//   // }

//   // Future<void> _loadMerchantSelection() async {
//   //   final result = await Session.instance.isAllMerchantSelected();
//   //   setState(() {
//   //     isAllMerchantSelected = result ?? false;
//   //   });
//   // }

//   // Future<void> _loadIsRedirectToQrisPage() async {
//   //   final result = await Session.instance.isRedirectToQrisPage();
//   //   setState(() {
//   //     isRedirectToQrisPage = result ?? false;
//   //   });
//   // }

//   // Future<void> _loadIsQrisStatic() async {
//   //   final result = await Session.instance.isQrisStatic();
//   //   setState(() {
//   //     isQrisStatic = result ?? false;
//   //   });
//   // }

//   // bool isMerchantNonActive() {
//   //   return merchant?.nmid == null ||
//   //       merchant!.nmid!.isEmpty ||
//   //       merchant?.raw == null ||
//   //       merchant!.raw!.isEmpty;
//   // }

//   // bool isDontHaveMerchant() {
//   //   return merchant == null;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final bottomInset = MediaQuery.of(context).padding.bottom;
//     final paddingBottom = Platform.isIOS ? 0 : 16;

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.light,

//       child: PopScope(
//         canPop: false,
//         child: Scaffold(
//           body: Stack(
//             children: [
//               IndexedStack(index: _currentIndex, children: _pages),

//               Positioned(
//                 left: 16,
//                 right: 16,
//                 bottom: bottomInset > 0 ? bottomInset + paddingBottom : 16,
//                 child: SizedBox(
//                   height: 120,
//                   child: Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: _buildBottomNav(),
//                       ),

//                       Positioned(
//                         bottom: 8,
//                         child: GestureDetector(
//                           behavior: HitTestBehavior.translucent,
//                           onTap: () async {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => ScanQrisPage()),
//                             );
//                           },
//                           child: _buildFloatingButton(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNav() {
//     return Container(
//       decoration: BoxDecoration(color: Colors.transparent),
//       child: ClipRRect(
//         child: Container(
//           padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
//           // color: Colors.white,
//           child: Row(
//             children: [
//               Expanded(
//                 child: _navItem(
//                   index: 0,
//                   iconPath: AppImages.icHome,
//                   iconPathInactive: AppImages.icHomeInactive,
//                 ),
//               ),

//               const Expanded(child: SizedBox()),
//               Expanded(
//                 child: _navItem(
//                   index: 2,
//                   iconPath: AppImages.icHistory,
//                   iconPathInactive: AppImages.icHistoryInactive,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFloatingButton() {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [
//                 Color(0xFFFF8A00), // orange
//                 Color(0xFFFF0033), // red
//               ],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.18),
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//           child: Image.asset(AppImages.icQr, width: 30, height: 30),
//         ),
//         SizedBox(height: 12),
//         Image.asset(AppImages.icQris, width: 50, height: 18),
//       ],
//     );
//   }

//   /// Widget untuk menu selain tombol tengah
//   Widget _navItem({
//     required int index,
//     required String iconPath,
//     required String iconPathInactive,
//   }) {
//     final bool isActive = _currentIndex == index;

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () => _onTabTapped(index),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               isActive ? iconPath : iconPathInactive,
//               width: 32,
//               height: 32,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
