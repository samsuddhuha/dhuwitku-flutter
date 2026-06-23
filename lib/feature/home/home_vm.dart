import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/core/service/speech_service.dart';
import 'package:dhuwitku/core/session/session.dart';
import 'package:dhuwitku/feature/home/add_dhuwit_page.dart';
import 'package:dhuwitku/network/remotedata/auth/model/user_model.dart';
import 'package:dhuwitku/network/remotedata/dhuwit/dhuwit_remote_data.dart';
import 'package:dhuwitku/network/remotedata/home/home_remote_data.dart';
import 'package:dhuwitku/network/remotedata/home/model/dashboard_summary_model.dart';
import 'package:dhuwitku/network/remotedata/report/model/dhuwit_model.dart';
import 'package:dhuwitku/network/remotedata/report/report_remote_data.dart';
import 'package:dhuwitku/util/extension/int_extension.dart';
import 'package:flutter/material.dart';

class HomeVm extends BaseVm {
  final BuildContext context;

  final HomeRemoteData _remoteData = HomeRemoteData();
  final ReportRemoteData _reportRemoteData = ReportRemoteData();
  final DhuwitRemoteData _dhuwitRemoteData = DhuwitRemoteData();

  final ScrollController scrollController = ScrollController();

  HomeVm(this.context);

  UserModel? user;
  DashboardSummaryModel? dashboard;
  List<DhuwitModel> listHistoryDhuwit = [];

  bool isLoadingDashboard = false;
  bool isLoadingHistory = false;

  String speechText = '';
  bool isListening = false;

  Future<void> init() async {
    getUser();
    getDashboardSummary();
    getDhuwitHistory();
  }

  Future<void> getUser() async {
    user = await Session.instance.getUser();
    notifyListeners();
  }

  String getName() {
    return user?.name.split(' ').first ?? '';
  }

  String getBalanceText() {
    final total = dashboard?.totalCountDhuwit;

    final balance =
        (total?.inCount?.total ?? 0) - (total?.outCount?.total ?? 0);

    return balance.toRupiah(withSymbol: true);
  }

  String getMonthlySpendText() {
    final value = dashboard?.totalSpendMonth ?? 0;
    return value.toRupiah();
  }

  String getDailySpendText() {
    final value = dashboard?.totalSpendDay ?? 0;
    return value.toRupiah();
  }

  String getTitleHistory() {
    final total = listHistoryDhuwit.length >= 10
        ? '10'
        : '${listHistoryDhuwit.length}';

    return '$total Riwayat Terbaru';
  }

  Future<void> onTopUpClicked() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDhuwitPage()),
    );

    if (result != null && context.mounted) {
      getDashboardSummary();
      getDhuwitHistory();
    }
  }

  Future<void> onTapMic() async {
    if (isListening) {
      await stopListening();
      return;
    }

    final available = await SpeechService.instance.initSpeech();
    if (!available) return;

    speechText = '';
    isListening = true;
    notifyListeners();

    await SpeechService.instance.startListening(
      onResult: (text) {
        speechText = text;
        notifyListeners();
      },
      onStop: () {
        isListening = false;
        notifyListeners();
      },
    );
  }

  Future<void> stopListening() async {
    await SpeechService.instance.stopListening();
    isListening = false;
    notifyListeners();
  }

  Future<void> parserDataFromText() async {
    try {
      showLoading(context, true);

      final response = await _dhuwitRemoteData.createFromText(
        speechText: speechText,
      );

      final data = response['data'] as Map<String, dynamic>? ?? {};

      final status = data['status'] as int?;
      final nominal = data['nominal'] as int?;
      final information = data['information'] as String?;
      final dateDhuwit = data['date_dhuwit'] as String?;

      if (!context.mounted) return;
      showLoading(context, false);

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddDhuwitPage(
            status: status,
            nominal: nominal,
            information: information,
            dateDhuwit: dateDhuwit,
          ),
        ),
      );

      if (result != null && context.mounted) {
        getDashboardSummary();
        getDhuwitHistory();
      }

      notifyListeners();
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> getDashboardSummary() async {
    try {
      isLoadingDashboard = true;
      notifyListeners();

      final response = await _remoteData.getDashboardSummary();
      final data = response['data'] as Map<String, dynamic>;
      dashboard = DashboardSummaryModel.fromJson(data);

      isLoadingDashboard = false;
      notifyListeners();
    } catch (e) {
      isLoadingDashboard = false;

      if (!context.mounted) return;
      setError(context, e.toString().replaceFirst('Exception: ', ''));

      notifyListeners();
    }
  }

  Future<void> getDhuwitHistory() async {
    try {
      isLoadingHistory = true;
      notifyListeners();

      final response = await _reportRemoteData.getDhuwitHistory(limit: 10);

      final List<DhuwitModel> list = (response['data'] as List)
          .map((e) => DhuwitModel.fromJson(e))
          .toList();

      listHistoryDhuwit = list;

      isLoadingHistory = false;
      notifyListeners();
    } catch (e) {
      isLoadingHistory = false;

      if (!context.mounted) return;
      setError(context, e.toString().replaceFirst('Exception: ', ''));

      notifyListeners();
    }
  }

  Future<void> openUpdatePage(
    String id,
    int? status,
    int? nominal,
    String? information,
    String? dateDhuwit,
  ) async {
    if (isLoadingHistory) {
      return;
    }
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
      getDashboardSummary();
      getDhuwitHistory();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
