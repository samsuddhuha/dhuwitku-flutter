import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> with RouteAware {
  int _currentIndex = 0;
  // MerchantModel? merchant;
  bool isAllMerchantSelected = false;
  bool isRedirectToQrisPage = false;
  bool isQrisStatic = false;

  final List<Widget> _pages = const [
    HomePage(),
    SizedBox(), // index 2 adalah tombol tengah
    // ReportPage(),
  ];

  @override
  void initState() {
    super.initState();
    // _loadMerchantSelection();
    // _loadSelectedIndexBottomNavbar();
    // _getMerchant();
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      // tombol tengah
      return;
    }

    setState(() => _currentIndex = index);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      // routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    // routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Future<void> didPopNext() async {}

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: IndexedStack(index: _currentIndex, children: _pages),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.white, width: 1)),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _navItem(
                    currentIndex: _currentIndex,
                    index: 0,
                    iconPath: AppImages.icHomeInactive,
                    iconPathActive: AppImages.icHome,
                    label: "Beranda",
                  ),
                ),

                SizedBox(
                  width: 86,
                  height: 52,
                  child: GestureDetector(
                    onTap: () async {},
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 6),
                          ],
                        ),
                        child: Image.asset(
                          AppImages.icCircleHelp,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: _navItem(
                    currentIndex: _currentIndex,
                    index: 2,
                    iconPath: AppImages.icHistoryInactive,
                    iconPathActive: AppImages.icHistory,
                    label: "Riwayat",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int currentIndex,
    required int index,
    required String iconPath,
    required String iconPathActive,
    required String label,
  }) {
    final bool isActive = currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (index == 1) return;
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isActive ? iconPathActive : iconPath,
              width: 24,
              height: 24,
              color: isActive ? AppColors.tundora : AppColors.grey,
            ),

            const SizedBox(height: 4),

            TextApp.xSmall(
              label,
              color: isActive ? AppColors.tundora : AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
