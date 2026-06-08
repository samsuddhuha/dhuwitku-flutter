// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/core/base/base_vm.dart';

// class HomeVm extends BaseVm {
//   final BuildContext context;

//   // final UserRemoteData _userRemoteData = UserRemoteData();
//   // final TransactionRemoteData _transactionRemoteData = TransactionRemoteData();
//   final ScrollController scrollController = ScrollController();

//   HomeVm(this.context);

//   // UserModel? user;
//   // MerchantModel? merchant;
//   // bool? isAllMerchantSelected;
//   // BalanceModel? balance;
//   // bool? isPinExist;
//   // bool isMerchantNonActive = false;
//   // DateTime startDate = DateTime.now();
//   // DateTime endDate = DateTime.now();

//   // final List<QrisDataModel> transactions = [];
//   // bool isLastPage = false;
//   // bool isLoadingBalance = false;
//   // int page = 1;
//   // bool isHidebalance = true;
//   // int selectedFilter = 0;
//   // DateTime lastGetBalanceAt = DateTime.now();

//   Future<void> init() async {
//     // scrollController.addListener(_onScroll);

//     // getUser();
//     // getMerchant();
//     // getPinStatus();
//     // updateDateRange(0);

//     // getBalance();
//     // getListTransaction();
//   }

//   // Future<void> getUser() async {
//   //   user = await Session.instance.getUser();
//   //   notifyListeners();
//   // }

//   // Future<void> getMerchant() async {
//   //   merchant = await Session.instance.getMerchant();
//   //   await getIsAllMerchantSelected();
//   //   checkMerchantStatus();
//   //   notifyListeners();
//   // }

//   // Future<void> getIsAllMerchantSelected() async {
//   //   isAllMerchantSelected = await Session.instance.isAllMerchantSelected();
//   // }

//   // Future<void> checkMerchantStatus() async {
//   //   final isAllSelected =
//   //       await Session.instance.isAllMerchantSelected() ?? false;

//   //   if (isAllSelected) {
//   //     isMerchantNonActive = false;
//   //   } else {
//   //     isMerchantNonActive =
//   //         merchant?.nmid == null ||
//   //         merchant!.nmid!.isEmpty ||
//   //         merchant?.raw == null ||
//   //         merchant!.raw!.isEmpty;
//   //   }

//   //   notifyListeners();
//   // }

//   // String merchantName() {
//   //   if (isAllMerchantSelected != true) {
//   //     return merchant?.name ?? '-';
//   //   } else {
//   //     return 'Semua Merchant';
//   //   }
//   // }

//   // Future<void> getBalance() async {
//   //   try {
//   //     isLoadingBalance = true;
//   //     final response = await _userRemoteData.getBalance(
//   //       startDate: startDate.toStringDate(format: 'yyyy-MM-dd'),
//   //       endDate: endDate.toStringDate(format: 'yyyy-MM-dd'),
//   //     );
//   //     final data = response['data'] as Map<String, dynamic>;
//   //     balance = BalanceModel.fromJson(data);
//   //     lastGetBalanceAt = DateTime.now();
//   //     isLoadingBalance = false;
//   //     notifyListeners();
//   //   } catch (e) {
//   //     if (!context.mounted) return;
//   //     isLoadingBalance = false;
//   //     setError(context, e.toString().replaceFirst('Exception: ', ''));
//   //   }
//   // }

//   // Future<void> getPinStatus() async {
//   //   if (isPinExist == true) {
//   //     return;
//   //   }
//   //   try {
//   //     final response = await _userRemoteData.getPinStatus();
//   //     final data = response['data'] as Map<String, dynamic>;
//   //     isPinExist = data['status'] as bool?;
//   //     notifyListeners();
//   //   } catch (e) {
//   //     if (!context.mounted) return;
//   //     setError(context, e.toString().replaceFirst('Exception: ', ''));
//   //   }
//   // }

//   // Future<void> pullRefresh() async {
//   //   page = 1;
//   //   getListTransaction();
//   // }

//   // Future<void> getListTransaction() async {
//   //   try {
//   //     showLoading(context, true);
//   //     final merchantId = await Session.instance.isAllMerchantSelected() == true
//   //         ? ''
//   //         : merchant?.id.toString() ?? '';

//   //     final response = await _transactionRemoteData.historyCashIn(
//   //       page: page,
//   //       startDate: startDate.toStringDate(format: 'yyyy-MM-dd'),
//   //       endDate: endDate.toStringDate(format: 'yyyy-MM-dd'),
//   //       userQrisId: merchantId.isEmpty ? null : merchantId,
//   //     );

//   //     isLastPage = !(response['has_next_page'] ?? false);

//   //     final List<QrisDataModel> list = (response['histories'] as List)
//   //         .map((e) => QrisDataModel.fromJson(e))
//   //         .toList();

//   //     if (page == 1) {
//   //       transactions.clear();
//   //       transactions.addAll(list);
//   //     } else {
//   //       transactions.addAll(list);
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

//   // void _onScroll() {
//   //   if (!scrollController.hasClients) return;

//   //   final threshold = 100.0;
//   //   final maxScroll = scrollController.position.maxScrollExtent;
//   //   final currentScroll = scrollController.position.pixels;

//   //   if (maxScroll - currentScroll <= threshold) {
//   //     if (!isLoading && !isLastPage) {
//   //       page++;
//   //       getListTransaction();
//   //     }
//   //   }
//   // }

//   // void updateSelectedFilter(int filter) {
//   //   selectedFilter = filter;
//   //   page = 1;
//   //   updateDateRange(filter);

//   //   getBalance();
//   //   getListTransaction();
//   //   notifyListeners();
//   // }

//   // void updateIsHideBalance() {
//   //   isHidebalance = !isHidebalance;
//   //   notifyListeners();
//   // }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
// }
