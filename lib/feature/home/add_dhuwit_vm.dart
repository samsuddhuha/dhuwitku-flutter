import 'package:dhuwitku/component/bottomsheet/select_date_bottom_sheet.dart';
import 'package:dhuwitku/component/bottomsheet/select_time_bottom_sheet.dart';
import 'package:dhuwitku/core/base/base_vm.dart';
import 'package:dhuwitku/network/remotedata/dhuwit/dhuwit_remote_data.dart';
import 'package:dhuwitku/util/extension/int_extension.dart';
import 'package:dhuwitku/util/extension/string_extension.dart';
import 'package:dhuwitku/util/helper/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDhuwitVm extends BaseVm {
  final BuildContext context;
  final int? status;
  final int? nominal;
  final String? information;
  final String? dateDhuwit;
  final String? idDhuwit;

  final DhuwitRemoteData _remoteData = DhuwitRemoteData();

  AddDhuwitVm(
    this.context,
    this.status,
    this.nominal,
    this.information,
    this.dateDhuwit,
    this.idDhuwit,
  ) {
    initState();
  }

  final typeController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final nominalController = TextEditingController();
  final descriptionController = TextEditingController();

  String? typeError;
  String? nominalError;
  String? informationError;

  String _lastValidNominal = '';
  String _lastDate = '';

  void initState() {
    if (status != null) {
      typeController.text = status == 1 ? 'Pemasukan' : 'Pengeluaran';
    }

    final now = DateTime.now();
    DateTime date = now;
    DateTime time = now;
    _lastDate = DateFormat('yyyy-MM-dd', 'id_ID').format(date);

    String stringDate = dateDhuwit ?? '';
    if (dateDhuwit != null && stringDate.isNotEmpty) {
      try {
        final parsed = DateTime.parse(stringDate);

        date = parsed;
        _lastDate = DateFormat('yyyy-MM-dd', 'id_ID').format(date);

        if (stringDate.contains(':')) {
          time = parsed;
        }
      } catch (_) {}
    }

    dateController.text = DateFormat('dd MMM yyyy', 'id_ID').format(date);
    timeController.text = DateFormat('HH:mm').format(time);

    if (nominal != null) {
      nominalController.text = nominal?.toRupiah() ?? '';
    }

    if (information != null) {
      descriptionController.text = information ?? '';
    }

    notifyListeners();
  }

  void validateForm() {
    final type = typeController.text.trim();
    if (type.isEmpty) {
      typeError = "Pilih tipe terlebih dahulu";
    } else {
      typeError = null;
    }

    final nominal = nominalController.text.trim().toIntFromRupiah();
    if (nominal == 0) {
      nominalError = "Nominal tidak boleh kosong";
    } else {
      nominalError = null;
    }

    final information = descriptionController.text.trim();
    if (information.isEmpty) {
      informationError = "Keterangan tidak boleh kosong";
    } else {
      informationError = null;
    }

    notifyListeners();
  }

  void selectDate(BuildContext context) {
    final DateTime initialDate = DateFormat(
      'dd MMM yyyy',
    ).parse(dateController.text);

    showSelectDateBottomSheet(
      context: context,
      type: DatePickerType.date,
      titleText: "Pilih Tanggal Transaksi",
      buttonText: "Pilih",
      minYear: 50,
      initialDate: initialDate,
      onSelected: (date) {
        final dateTime = date as DateTime;
        _lastDate = DateFormat('yyyy-MM-dd').format(dateTime);
        dateController.text = DateFormat('dd MMM yyyy').format(dateTime);
      },
    );
  }

  void selectTime(BuildContext context) {
    TimeOfDay initialTime = TimeOfDay.now();

    try {
      final time = DateFormat('HH:mm').parse(timeController.text);

      initialTime = TimeOfDay(hour: time.hour, minute: time.minute);
    } catch (_) {}

    showSelectTimeBottomSheet(
      context: context,
      initialTime: initialTime,
      titleText: "Pilih Waktu Transaksi",
      buttonText: "Pilih",
      onSelected: (time) {
        timeController.text =
            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
      },
    );
  }

  void onNominalChanged(String value) {
    final number = value.toIntFromRupiah();

    const maxValue = 999999999999999;

    if (number > maxValue) {
      nominalError = "Nominal terlalu besar";

      nominalController.value = TextEditingValue(
        text: _lastValidNominal,
        selection: TextSelection.collapsed(offset: _lastValidNominal.length),
      );

      notifyListeners();
      return;
    }

    nominalError = null;

    final formatted = number.toRupiah();

    _lastValidNominal = formatted;

    nominalController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    notifyListeners();
  }

  void validateData() {
    validateForm();

    if (nominalError == null && typeError == null && informationError == null) {
      if (idDhuwit == null) {
        submitDhuwit();
      } else {
        updateDhuwit();
      }
    }
  }

  Future<void> submitDhuwit() async {
    try {
      showLoading(context, true);

      final response = await _remoteData.submitDhuwit(
        status: typeController.text == 'Pemasukan' ? 1 : 2,
        nominal: nominalController.text.toIntFromRupiah(),
        dateTime: '$_lastDate ${timeController.text}',
        information: descriptionController.text,
      );

      final message = response['message'] as String?;

      if (!context.mounted) return;
      SnackbarHelper.show(context, message ?? 'Data Berhasil di Tambah');
      showLoading(context, false);
      Navigator.pop(context, true);
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> updateDhuwit() async {
    try {
      showLoading(context, true);

      final response = await _remoteData.updateDhuwit(
        id: idDhuwit ?? '',
        status: typeController.text == 'Pemasukan' ? 1 : 2,
        nominal: nominalController.text.toIntFromRupiah(),
        dateTime: '$_lastDate ${timeController.text}',
        information: descriptionController.text,
      );

      final message = response['message'] as String?;

      if (!context.mounted) return;
      SnackbarHelper.show(context, message ?? 'Data Berhasil di Update');
      showLoading(context, false);
      Navigator.pop(context, true);
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> daleteDhuwit() async {
    try {
      showLoading(context, true);

      final response = await _remoteData.daleteDhuwit(id: idDhuwit ?? '');

      final message = response['message'] as String?;

      if (!context.mounted) return;
      SnackbarHelper.show(context, message ?? 'Data Berhasil di Hapus');
      showLoading(context, false);
      Navigator.pop(context, true);
    } catch (e) {
      if (!context.mounted) return;
      showLoading(context, false);
      setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
