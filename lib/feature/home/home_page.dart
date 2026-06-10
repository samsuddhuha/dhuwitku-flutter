import 'dart:ui';

import 'package:dhuwitku/component/divider/divider_app.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/account/account_page.dart';
import 'package:dhuwitku/feature/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  HomeVm? _vm;

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
    return ChangeNotifierProvider(
      create: (context) {
        final vm = HomeVm(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          vm.init();
        });
        return vm;
      },
      child: Consumer<HomeVm>(
        builder: (context, vm, _) {
          _vm = vm;
          return PopScope(
            canPop: true,
            child: Scaffold(
              backgroundColor: AppColors.surfaceGrey,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextApp.h4(
                            'Hai, Sam 👋',
                            fontWeight: FontWeight.bold,
                            color: AppColors.tundora,
                          ),

                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AccountPage(),
                                ),
                              ),
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Icon(
                                Icons.person,
                                size: 28,
                                color: AppColors.tundora,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildDhuwitCard(vm),
                    SizedBox(height: 48),
                    _buildHistoryCard(vm),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDhuwitCard(HomeVm vm) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextApp.small('Dhuwit', color: AppColors.tundora),

          const SizedBox(height: 4),

          InkWell(
            onTap: vm.onTopUpClicked,
            child: Row(
              children: [
                Expanded(
                  child: TextApp.h4(
                    vm.getBalanceText(),
                    color: AppColors.tundora,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Icon(Icons.add, size: 20, color: AppColors.tundora),
              ],
            ),
          ),

          const SizedBox(height: 16),

          DividerApp(lineColor: AppColors.lightGrey),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                flex: 9,
                child: TextApp.small(
                  'Pengeluaran Bulan Ini',
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                flex: 11,
                child: TextApp.small(
                  vm.getMonthlySpendText(),
                  textAlign: TextAlign.end,
                  color: AppColors.tundora,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                flex: 9,
                child: TextApp.small(
                  'Pengeluaran Hari Ini',
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                flex: 11,
                child: TextApp.small(
                  vm.getDailySpendText(),
                  textAlign: TextAlign.end,
                  color: AppColors.tundora,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(HomeVm vm) {
    final dummyTransactions = [
      {
        "icon": AppImages.icPayment,
        "date": "Hari ini, 09:50",
        "description": "Bopet Mini",
        "price": "- Rp 119.000",
      },
      {
        "icon": AppImages.icTransfer,
        "date": "Hari ini, 08:12",
        "description": "Top Up Saldo",
        "price": "+ Rp 500.000",
      },
      {
        "icon": AppImages.icTransfer,
        "date": "Kemarin, 21:14",
        "description": "Transfer ke Andi",
        "price": "- Rp 75.000",
      },
    ];

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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dummyTransactions.length,
                separatorBuilder: (_, __) => Divider(
                  color: Colors.black.withValues(alpha: 0),
                  height: 24,
                ),
                itemBuilder: (context, index) {
                  final item = dummyTransactions[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: _buildTransactionItem(
                      iconPath: item["icon"] as String,
                      iconColor: AppColors.secondary,
                      date: item["date"] as String,
                      description: item["description"] as String,
                      price: item["price"] as String,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    bool showNumber = false,
    int? number,
    required String iconPath,
    required Color iconColor,
    required String description,
    required String date,
    required String price,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 10),
      child: Row(
        children: [
          if (showNumber) ...[
            TextApp.xSmall(number.toString(), fontWeight: FontWeight.w600),
            const SizedBox(width: 12),
          ],

          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 18,
                height: 18,
                fit: BoxFit.contain,
                color: iconColor,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextApp.h5(
                  description,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                TextApp.small(
                  date,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextApp.small(
                price,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildEmptyState() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         TextApp.small(
  //           'Belum ada transaksi',
  //           fontWeight: FontWeight.w600,
  //           color: AppColors.textPrimary,
  //         ),
  //         const SizedBox(height: 8),
  //         TextApp.xSmall(
  //           'Transaksi masuk akan muncul di sini',
  //           color: AppColors.textSecondary,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: 24),
  //       ],
  //     ),
  //   );
  // }
}
