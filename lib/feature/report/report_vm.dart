// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/core/base/base_vm.dart';

// class ReportVm extends BaseVm {
//   final BuildContext context;
//   // final TransactionRemoteData _transactionRemoteData = TransactionRemoteData();

//   final TextEditingController searchController = TextEditingController();
//   final ScrollController scrollController = ScrollController();

//   ReportVm(this.context);

//   int tabIndex = 0;

//   // MerchantModel? merchant;
//   bool? isAllMerchantSelected;
//   DateTime startDate = DateTime.now();
//   DateTime endDate = DateTime.now();

//   // final List<QrisDataModel> transactionsIn = [];
//   // final List<CashOutModel> transactionsOut = [];
//   bool isLastPageReportIn = false;
//   int pageReportIn = 1;
//   bool isLastPageReportOut = false;
//   int pageReportOut = 1;

//   bool get isReportIn => tabIndex == 0;

//   Future<void> init() async {
//     // scrollController.addListener(_onScroll);

//     // getMerchant();
//     // updateDateRange(7);
//     // getListTransaction();
//   }

//   void onSearch(String value) {
//     // reset pagination state
//   }

//   // Future<void> getMerchant() async {
//   //   merchant = await Session.instance.getMerchant();
//   //   await getIsAllMerchantSelected();
//   //   notifyListeners();
//   // }

//   // Future<void> getIsAllMerchantSelected() async {
//   //   isAllMerchantSelected = await Session.instance.isAllMerchantSelected();
//   // }

//   // String merchantName() {
//   //   if (isAllMerchantSelected != true) {
//   //     return merchant?.name ?? '-';
//   //   } else {
//   //     return 'Semua Merchant';
//   //   }
//   // }

//   // Future<void> changeTab(int index) async {
//   //   if (tabIndex == index) return;

//   //   tabIndex = index;

//   //   // reset pagination state
//   //   pageReportIn = 1;
//   //   pageReportOut = 1;
//   //   isLastPageReportIn = false;
//   //   isLastPageReportOut = false;

//   //   // reset scroll ke atas
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     if (scrollController.hasClients) {
//   //       scrollController.jumpTo(0);
//   //     }
//   //   });

//   //   await getListTransaction();
//   //   notifyListeners();
//   // }

//   // Future<void> pullRefresh() async {
//   //   pageReportIn = 1;
//   //   pageReportOut = 1;
//   //   getListTransaction();
//   // }

//   // Future<void> getListTransaction() async {
//   //   if (tabIndex == 1) {
//   //     await getListTransactionOut();
//   //   } else {
//   //     await getListTransactionIn();
//   //   }
//   // }

//   // Future<void> getListTransactionIn() async {
//   //   try {
//   //     showLoading(context, true);
//   //     final merchantId = await Session.instance.isAllMerchantSelected() == true
//   //         ? ''
//   //         : merchant?.id.toString() ?? '';

//   //     final response = await _transactionRemoteData.historyCashIn(
//   //       page: pageReportIn,
//   //       startDate: startDate.toStringDate(format: 'yyyy-MM-dd'),
//   //       endDate: endDate.toStringDate(format: 'yyyy-MM-dd'),
//   //       userQrisId: merchantId.isEmpty ? null : merchantId,
//   //     );

//   //     isLastPageReportIn = !(response['has_next_page'] ?? false);

//   //     final List<QrisDataModel> list = (response['histories'] as List)
//   //         .map((e) => QrisDataModel.fromJson(e))
//   //         .toList();

//   //     if (pageReportIn == 1) {
//   //       transactionsIn.clear();
//   //       transactionsIn.addAll(list);
//   //     } else {
//   //       transactionsIn.addAll(list);
//   //     }

//   //     if (!context.mounted) return;
//   //     showLoading(context, false);
//   //   } catch (e) {
//   //     if (!context.mounted) return;
//   //     showLoading(context, false);
//   //     setError(context, e.toString().replaceFirst('Exception: ', ''));
//   //   }
//   // }

//   // Future<void> getListTransactionOut() async {
//   //   try {
//   //     showLoading(context, true);
//   //     final response = await _transactionRemoteData.historyCashOut(
//   //       page: pageReportOut,
//   //       startDate: startDate.toStringDate(format: 'yyyy-MM-dd'),
//   //       endDate: endDate.toStringDate(format: 'yyyy-MM-dd'),
//   //     );

//   //     isLastPageReportOut = !(response['has_next_page'] ?? false);

//   //     final List<CashOutModel> list = (response['histories'] as List)
//   //         .map((e) => CashOutModel.fromJson(e))
//   //         .toList();

//   //     if (pageReportOut == 1) {
//   //       transactionsOut.clear();
//   //       transactionsOut.addAll(list);
//   //     } else {
//   //       transactionsOut.addAll(list);
//   //     }

//   //     if (!context.mounted) return;
//   //     showLoading(context, false);
//   //   } catch (e) {
//   //     if (!context.mounted) return;
//   //     showLoading(context, false);
//   //     setError(context, e.toString().replaceFirst('Exception: ', ''));
//   //   }
//   // }

//   // (DateTime startDate, DateTime endDate) initDefaultDateRange(int countDay) {
//   //   final now = DateTime.now();

//   //   final endDate = DateTime(now.year, now.month, now.day, 12, 0, 0, 0);

//   //   final startDate = endDate.subtract(Duration(days: countDay));

//   //   return (startDate, endDate);
//   // }

//   // void updateDateRange(int rangeCountDay) {
//   //   final (start, end) = initDefaultDateRange(rangeCountDay);

//   //   startDate = start;
//   //   endDate = end;

//   //   notifyListeners();
//   // }

//   // Future<void> pickDateRange() async {
//   //   final now = DateTime.now();
//   //   final maxRangeDays = 30;

//   //   final DateTimeRange? picked = await showDateRangePicker(
//   //     context: context,
//   //     firstDate: now.subtract(Duration(days: maxRangeDays)),
//   //     lastDate: now,
//   //     initialDateRange: DateTimeRange(start: startDate, end: endDate),
//   //     builder: (context, child) {
//   //       if (child == null) return const SizedBox();

//   //       return Theme(
//   //         data: Theme.of(context).copyWith(
//   //           colorScheme: ColorScheme.light(
//   //             primary: AppColors.primary,
//   //             onPrimary: Colors.white,
//   //             secondaryContainer: AppColors.primary.withOpacity(0.15),
//   //           ),
//   //         ),
//   //         child: Localizations(
//   //           locale: const Locale('id', 'ID'),
//   //           delegates: const [
//   //             GlobalMaterialLocalizations.delegate,
//   //             GlobalWidgetsLocalizations.delegate,
//   //             GlobalCupertinoLocalizations.delegate,
//   //           ],
//   //           child: child,
//   //         ),
//   //       );
//   //     },
//   //   );

//   //   if (picked != null) {
//   //     startDate = picked.start;
//   //     endDate = picked.end;
//   //     getListTransaction();
//   //     notifyListeners();
//   //   }
//   // }

//   // String getDateLabel() {
//   //   final start = startDate;
//   //   final end = endDate;

//   //   final bool sameYear = start.year == end.year;

//   //   if (_isSameDay(start, end)) {
//   //     return start.toStringDate(format: 'dd MMM yyyy');
//   //   } else if (sameYear) {
//   //     final startStr = start.toStringDate(format: 'dd MMM');
//   //     final endStr = end.toStringDate(format: 'dd MMM yyyy');
//   //     return '$startStr - $endStr';
//   //   } else {
//   //     final startStr = start.toStringDate(format: 'dd MMM yyyy');
//   //     final endStr = end.toStringDate(format: 'dd MMM yyyy');
//   //     return '$startStr - $endStr';
//   //   }
//   // }

//   // bool _isSameDay(DateTime a, DateTime b) {
//   //   return a.year == b.year && a.month == b.month && a.day == b.day;
//   // }

//   // void _onScroll() {
//   //   if (!scrollController.hasClients) return;

//   //   const threshold = 100.0;
//   //   final position = scrollController.position;

//   //   if (position.maxScrollExtent - position.pixels > threshold) return;

//   //   final isLastPage = isReportIn ? isLastPageReportIn : isLastPageReportOut;

//   //   if (isLoading || isLastPage) return;

//   //   if (isReportIn) {
//   //     pageReportIn++;
//   //     getListTransactionIn();
//   //   } else {
//   //     pageReportOut++;
//   //     getListTransactionOut();
//   //   }
//   // }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
// }
