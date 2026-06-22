import 'package:dhuwitku/component/bottomsheet/select_date_bottom_sheet.dart';
import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/feature/home/add_dhuwit_page.dart';
import 'package:dhuwitku/network/remotedata/auth/model/user_model.dart';
import 'package:dhuwitku/network/remotedata/home/home_remote_data.dart';
import 'package:dhuwitku/network/remotedata/home/model/dhuwit_summary_model.dart';
import 'package:dhuwitku/network/remotedata/report/model/dhuwit_model.dart';
import 'package:dhuwitku/network/remotedata/report/report_remote_data.dart';
import 'package:dhuwitku/util/extension/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportVm extends BaseVm {
  final BuildContext context;

  final HomeRemoteData _remoteData = HomeRemoteData();
  final ReportRemoteData _reportRemoteData = ReportRemoteData();

  final ScrollController scrollController = ScrollController();
  final TextEditingController monthYearController = TextEditingController();

  ReportVm(this.context);

  UserModel? user;
  DhuwitSummaryModel? dhuwitSummary;
  List<DhuwitModel> allHistoryDhuwit = [];
  List<DhuwitModel> listHistoryDhuwit = [];

  bool isLoadingCard = false;
  bool isLoadingHistory = false;

  late int selectedMonth;
  late int selectedYear;
  bool incomeActive = true;
  bool spendActive = true;

  Future<void> init() async {
    final now = DateTime.now();

    selectedMonth = now.month;
    selectedYear = now.year;

    monthYearController.text = DateFormat(
      'MMMM yyyy',
      'id_ID',
    ).format(DateTime(selectedYear, selectedMonth));

    getDhuwitSummary();
    getDhuwitHistory();
  }

  String getMonthlySpendText() {
    final value = dhuwitSummary?.totalSpend ?? 0;
    return value.toRupiah(withSymbol: true);
  }

  String getMonthlyIncomeText() {
    final value = dhuwitSummary?.totalIncome ?? 0;
    return value.toRupiah(withSymbol: true);
  }

  Future<void> getDhuwitSummary() async {
    try {
      isLoadingCard = true;
      notifyListeners();

      final response = await _remoteData.getDhuwitSummary(
        month: selectedMonth,
        year: selectedYear,
      );

      final data = response['data'] as Map<String, dynamic>;
      dhuwitSummary = DhuwitSummaryModel.fromJson(data);

      isLoadingCard = false;
      notifyListeners();
    } catch (e) {
      isLoadingCard = false;

      if (!context.mounted) return;
      setError(context, e.toString().replaceFirst('Exception: ', ''));

      notifyListeners();
    }
  }

  Future<void> getDhuwitHistory() async {
    try {
      isLoadingHistory = true;
      notifyListeners();

      final response = await _reportRemoteData.getDhuwitHistory(
        month: selectedMonth,
        year: selectedYear,
      );

      final List<DhuwitModel> list = (response['data'] as List)
          .map((e) => DhuwitModel.fromJson(e))
          .toList();

      allHistoryDhuwit = list;
      updateListDhuwit();

      isLoadingHistory = false;
      notifyListeners();
    } catch (e) {
      isLoadingHistory = false;

      if (!context.mounted) return;
      setError(context, e.toString().replaceFirst('Exception: ', ''));

      notifyListeners();
    }
  }

  void updateSelectedFilter({
    required bool incomeActive,
    required bool spendActive,
  }) {
    this.incomeActive = incomeActive;
    this.spendActive = spendActive;

    updateListDhuwit();

    notifyListeners();
  }

  void updateListDhuwit() {
    if (incomeActive && spendActive) {
      listHistoryDhuwit = List.from(allHistoryDhuwit);
    } else if (incomeActive) {
      listHistoryDhuwit = allHistoryDhuwit
          .where((item) => item.status == 1)
          .toList();
    } else if (spendActive) {
      listHistoryDhuwit = allHistoryDhuwit
          .where((item) => item.status == 2)
          .toList();
    } else {
      listHistoryDhuwit = [];
    }

    notifyListeners();
  }

  void openSelectDate() {
    showSelectDateBottomSheet(
      context: context,
      type: DatePickerType.monthYear,
      titleText: "Pilih Bulan & Tahun",
      buttonText: "Pilih",
      initialDate: DateTime(selectedYear, selectedMonth),
      onSelected: (date) async {
        selectedMonth = date.month;
        selectedYear = date.year;

        monthYearController.text = DateFormat(
          'MMMM yyyy',
          'id_ID',
        ).format(date);

        await Future.wait([getDhuwitSummary(), getDhuwitHistory()]);
      },
    );
  }

  Future<void> openUpdatePage(
    String id,
    int? status,
    int? nominal,
    String? information,
    String? dateDhuwit,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDhuwitPage(
          idDhuwit: id,
          status: status,
          nominal: nominal,
          information: information,
          dateDhuwit: dateDhuwit,
        ),
      ),
    );

    if (result != null && context.mounted) {
      getDhuwitSummary();
      getDhuwitHistory();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
