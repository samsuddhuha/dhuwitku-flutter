import 'package:dhuwitku/component/divider/divider_app.dart';
import 'package:dhuwitku/component/navbar/navbar.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/account/account_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AccountVm(context),
      child: Consumer<AccountVm>(
        builder: (context, vm, _) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            backgroundColor: AppColors.white,
            appBar: Navbar(title: ''),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildProfileInfoItem(vm),

                          SizedBox(height: 20),

                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.lightGrey,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                // _buildProfileMenuItem(
                                //   title: "Keamanan & Privasi",
                                //   iconPath: AppImages.icCircleSecurity,
                                //   onTap: () {},
                                // ),
                                // SizedBox(height: 12),

                                // _buildProfileMenuItem(
                                //   title: "Syarat dan Ketentuan",
                                //   iconPath: AppImages.icCircleReport,
                                //   onTap: () {
                                //     // vm.openWebTermCondition();
                                //   },
                                // ),

                                // SizedBox(height: 16),
                                // DividerApp(lineColor: AppColors.lightGrey),
                                // SizedBox(height: 16),
                                _buildLogoutItem(
                                  onTap: () {
                                    vm.logout();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileInfoItem(AccountVm vm) {
    return Column(
      children: [
        Image.asset(AppImages.icCircleUser, fit: BoxFit.contain, width: 80),
        SizedBox(height: 12),
        TextApp.h1(
          vm.user?.name ?? "Nama Pengguna",
          fontWeight: FontWeight.bold,
          color: AppColors.tundora,
        ),
        SizedBox(height: 4),
        TextApp.h4(vm.user?.email ?? ''),
      ],
    );
  }

  Widget _buildProfileMenuItem({
    required String title,
    required String iconPath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 40, height: 40, fit: BoxFit.contain),

            const SizedBox(width: 12),

            // 🔹 Title
            Expanded(child: TextApp.body(title)),

            // 🔹 Chevron (right arrow)
            const Icon(Icons.chevron_right, color: AppColors.tundora, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutItem({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icon circle
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(AppImages.icLogout, width: 24, height: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(child: TextApp.body("Keluar")),
          ],
        ),
      ),
    );
  }
}
