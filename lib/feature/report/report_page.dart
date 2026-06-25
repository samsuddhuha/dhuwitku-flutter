import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/component/label/label.dart';
import 'package:dhuwitku/component/navbar/navbar.dart';
import 'package:dhuwitku/component/shimmer/shimmer_view.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/report/report_vm.dart';
import 'package:dhuwitku/util/extension/date_extension.dart';
import 'package:dhuwitku/util/extension/int_extension.dart';
import 'package:dhuwitku/util/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with RouteAware {
  ReportVm? _vm;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this);
  //   _tabController.addListener(() {
  //     _vm?.changeTab(_tabController.index);
  //   });
  //   _loadSelectedIndexTabReport();
  // }

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
        final vm = ReportVm(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          vm.init();
        });
        return vm;
      },
      child: Consumer<ReportVm>(
        builder: (context, vm, _) {
          _vm = vm;
          return PopScope(
            canPop: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: Colors.white,
              appBar: Navbar(title: 'Riwayat'),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: InputField(
                        title: "Bulan & Tahun",
                        hintText: "Pilih bulan dan tahun",
                        controller: vm.monthYearController,
                        readOnly: true,
                        onTap: () {
                          vm.openSelectDate();
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDhuwitCard(vm),
                    SizedBox(height: 16),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Label(
                            text: 'Semua',
                            size: LabelSize.medium,
                            color: vm.allStatusActive
                                ? LabelColor.green
                                : LabelColor.grey,
                            onTap: () {
                              vm.updateSelectedFilter(
                                allStatusActive: true,
                                incomeActive: false,
                                spendActive: false,
                              );
                            },
                          ),
                          SizedBox(width: 8),
                          Label(
                            text: 'Pemasukan',
                            size: LabelSize.medium,
                            color: vm.incomeActive
                                ? LabelColor.green
                                : LabelColor.grey,
                            onTap: () {
                              vm.updateSelectedFilter(
                                allStatusActive: false,
                                incomeActive: true,
                                spendActive: false,
                              );
                            },
                          ),
                          SizedBox(width: 8),
                          Label(
                            text: 'Pengeluaran',
                            size: LabelSize.medium,
                            color: vm.spendActive
                                ? LabelColor.green
                                : LabelColor.grey,
                            onTap: () {
                              vm.updateSelectedFilter(
                                allStatusActive: false,
                                incomeActive: false,
                                spendActive: true,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
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

  Widget _buildDhuwitCard(ReportVm vm) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextApp.small('Ringkasan Bulan Ini'),
                // SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextApp.small(
                                'Pemasukan',
                                color: AppColors.darkGrey,
                              ),
                              SizedBox(width: 4),
                              Image.asset(
                                AppImages.icIn,
                                width: 14,
                                height: 14,
                                fit: BoxFit.contain,
                                color: AppColors.green,
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          vm.isLoadingCard
                              ? shimmerView(height: 19, width: 120)
                              : TextApp.body(
                                  vm.getMonthlyIncomeText(),
                                  textAlign: TextAlign.end,
                                  color: AppColors.tundora,
                                  fontWeight: FontWeight.w800,
                                ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextApp.small(
                                'Pengeluaran',
                                color: AppColors.darkGrey,
                              ),
                              SizedBox(width: 4),
                              Image.asset(
                                AppImages.icOut,
                                width: 14,
                                height: 14,
                                fit: BoxFit.contain,
                                color: AppColors.crimsonRed,
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          vm.isLoadingCard
                              ? shimmerView(height: 19, width: 120)
                              : TextApp.body(
                                  vm.getMonthlySpendText(),
                                  textAlign: TextAlign.end,
                                  color: AppColors.tundora,
                                  fontWeight: FontWeight.w800,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(ReportVm vm) {
    final transactions = vm.listHistoryDhuwit;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16),
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
          if (transactions.isEmpty && !vm.isLoadingHistory)
            _buildEmptyState(monthYear: vm.monthYearController.text)
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
                      iconColor: isIn ? AppColors.green : AppColors.crimsonRed,
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

  Widget _buildEmptyState({required String monthYear}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Image.asset(AppImages.imgEmpty, width: 140, fit: BoxFit.contain),
          const SizedBox(height: 16),
          TextApp.body(
            'Belum ada riwayat di $monthYear',
            color: AppColors.darkGrey,
          ),
        ],
      ),
    );
  }
}
