import 'dart:ui';

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
                          _buildProfileInfoItem(),

                          SizedBox(height: 20),
                          _buildMenuCard(),

                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              vm.logout();
                            },
                            child: TextApp.h4(
                              "Keluar akun",
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
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

  Widget _buildProfileInfoItem() {
    return Column(
      children: [
        Image.asset(AppImages.icUserBlue, fit: BoxFit.contain, width: 80),
        SizedBox(height: 12),
        TextApp.h1(
          "Inacash Ina",
          fontWeight: FontWeight.bold,
          color: AppColors.tundora,
        ),
        SizedBox(height: 4),
        TextApp.h4("0812345678910"),
      ],
    );
  }

  Widget _buildMenuCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white.withValues(alpha: 0.10),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.20),
              width: 1,
            ),
          ),

          child: Column(
            children: [
              _buildProfileMenuItem(
                title: "Bantuan",
                iconPath: AppImages.icCircleHelp,
                onTap: () async {},
              ),
              SizedBox(height: 16),
              _buildProfileMenuItem(
                title: "Akun",
                iconPath: AppImages.icCircleUser,
                onTap: () async {},
              ),
              SizedBox(height: 16),
              _buildProfileMenuItem(
                title: "Privasi & keamanan",
                iconPath: AppImages.icCircleSecurity,
                onTap: () async {},
              ),
              SizedBox(height: 16),
              _buildProfileMenuItem(
                title: "Pemberitahuan",
                iconPath: AppImages.icCircleNotification,
                onTap: () async {},
              ),
            ],
          ),
        ),
      ),
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 26,
              height: 26,
              fit: BoxFit.contain,
              color: AppColors.white,
            ),

            const SizedBox(width: 16),

            Expanded(child: TextApp.h5(title, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
