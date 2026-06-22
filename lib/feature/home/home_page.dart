import 'dart:ui';

import 'package:dhuwitku/component/bottomsheet/mic_bottom_sheet.dart';
import 'package:dhuwitku/component/divider/divider_app.dart';
import 'package:dhuwitku/component/shimmer/shimmer_view.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/account/account_page.dart';
import 'package:dhuwitku/feature/home/home_vm.dart';
import 'package:dhuwitku/feature/report/report_page.dart';
import 'package:dhuwitku/util/extension/date_extension.dart';
import 'package:dhuwitku/util/extension/int_extension.dart';
import 'package:dhuwitku/util/extension/string_extension.dart';
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
            canPop: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton(
                onPressed: () => _showMicBottomSheet(vm),
                backgroundColor: AppColors.primaryDark,
                child: const Icon(Icons.mic, color: AppColors.white),
              ),
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
                            'Hai, ${vm.getName()} 👋',
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
                              child: Image.asset(
                                AppImages.icCircleUser,
                                width: 28,
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDhuwitCard(vm),
                    Expanded(child: _buildHistoryCard(vm)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showMicBottomSheet(HomeVm vm) {
    vm.speechText = '';
    vm.onTapMic();
    showMicBottomSheet(context: context, vm: vm);
  }

  Widget _buildDhuwitCard(HomeVm vm) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey, width: 1),
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
                  child: vm.isLoadingDashboard
                      ? shimmerView(height: 24)
                      : TextApp.h4(
                          vm.getBalanceText(),
                          color: AppColors.tundora,
                          fontWeight: FontWeight.w800,
                        ),
                ),
                SizedBox(width: 8),
                const Icon(Icons.add, size: 20, color: AppColors.tundora),
              ],
            ),
          ),

          const SizedBox(height: 16),

          DividerApp(lineColor: AppColors.lightGrey),

          const SizedBox(height: 16),

          vm.isLoadingDashboard
              ? shimmerView(height: 17, width: double.infinity)
              : Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextApp.small(
                        'Pengeluaran Hari Ini',
                        color: AppColors.primaryDark,
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

          const SizedBox(height: 8),

          vm.isLoadingDashboard
              ? shimmerView(height: 17, width: double.infinity)
              : Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextApp.small(
                        'Pengeluaran Bulan Ini',
                        color: AppColors.primaryDark,
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
        ],
      ),
    );
  }

  Widget _buildHistoryCard(HomeVm vm) {
    final transactions = vm.listHistoryDhuwit;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextApp.body(
                    vm.getTitleHistory(),
                    fontWeight: FontWeight.bold,
                    color: AppColors.tundora,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportPage()),
                      );

                      if (result != null && context.mounted) {}
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextApp.small(
                        'Lihat Semua',
                        color: AppColors.tundora,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (transactions.isEmpty && !vm.isLoadingHistory)
                _buildEmptyState()
              else
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: vm.isLoadingHistory ? 3 : transactions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      if (vm.isLoadingHistory) {
                        return _buildTransactionItemShimmer();
                      }

                      final item = transactions[index];
                      final isIn = item.status == 1;
                      final date = item.dateDhuwit ?? '';

                      return InkWell(
                        onTap: () {
                          vm.openUpdatePage(
                            '${item.id}',
                            item.status,
                            item.nominal,
                            item.information,
                            item.dateDhuwit,
                          );
                        },
                        child: _buildTransactionItem(
                          iconPath: isIn ? AppImages.icIn : AppImages.icOut,
                          iconColor: isIn
                              ? AppColors.green
                              : AppColors.crimsonRed,
                          date: date.toDate().toStringDate(
                            format: date.contains(':')
                                ? 'EEEE, dd MMM yyyy HH:mm'
                                : 'EEEE, dd MMM yyyy',
                          ),
                          description: item.information ?? '',
                          price:
                              "${isIn ? '+' : '-'} ${item.nominal?.toRupiah(withSymbol: false)}",
                        ),
                      );
                    },
                  ),
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

          Center(
            child: Image.asset(
              iconPath,
              width: 18,
              height: 18,
              fit: BoxFit.contain,
              color: iconColor,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextApp.h5(
                  description,
                  color: AppColors.tundora,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                TextApp.xSmall(
                  date,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.darkGrey.withValues(alpha: 0.80),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextApp.body(
                price,
                color: AppColors.tundora,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItemShimmer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerView(width: 160, height: 16),
                const SizedBox(height: 6),
                shimmerView(width: 110, height: 12),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [shimmerView(width: 90, height: 16)],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Image.asset(AppImages.imgEmpty, width: 140, fit: BoxFit.contain),
          const SizedBox(height: 16),
          TextApp.body(
            'Belum ada riwayat pencatatan keuangan',
            color: AppColors.darkGrey,
          ),
        ],
      ),
    );
  }
}
