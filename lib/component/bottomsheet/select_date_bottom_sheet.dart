import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DatePickerType { date, monthYear, year, month }

void showSelectDateBottomSheet({
  required BuildContext context,
  required DatePickerType type,
  required Function(dynamic value) onSelected,
  DateTime? initialDate,
  String titleText = "Select Date",
  String buttonText = "Done",
  int minYear = 1,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return _DatePickerBottomSheet(
        type: type,
        onSelected: onSelected,
        initialDate: initialDate,
        titleText: titleText,
        buttonText: buttonText,
        minYear: minYear,
      );
    },
  );
}

class _DatePickerBottomSheet extends StatefulWidget {
  final DatePickerType type;
  final Function(dynamic value) onSelected;
  final DateTime? initialDate;
  final String titleText;
  final String buttonText;
  final int? minYear;

  const _DatePickerBottomSheet({
    required this.type,
    required this.onSelected,
    this.initialDate,
    required this.titleText,
    required this.buttonText,
    this.minYear,
  });

  @override
  State<_DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<_DatePickerBottomSheet> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  int get minYear => DateTime.now().year - widget.minYear!;
  final int maxYear = DateTime.now().year;

  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final initial = widget.initialDate ?? DateTime(now.year - 20, now.month, 1);

    selectedDay = initial.day;
    selectedMonth = initial.month;
    selectedYear = initial.year;

    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);

    monthController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );

    yearController = FixedExtentScrollController(
      initialItem: selectedYear - minYear,
    );
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  bool get showDay => widget.type == DatePickerType.date;

  bool get showMonth =>
      widget.type == DatePickerType.date ||
      widget.type == DatePickerType.monthYear ||
      widget.type == DatePickerType.month;

  bool get showYear =>
      widget.type == DatePickerType.date ||
      widget.type == DatePickerType.monthYear ||
      widget.type == DatePickerType.year;

  final List<String> monthNames = List.generate(
    12,
    (index) => DateFormat('MMMM', 'id_ID').format(DateTime(0, index + 1)),
  );

  @override
  Widget build(BuildContext context) {
    final double sheetHeight = MediaQuery.of(context).size.height * 0.5;

    final int maxDay = _daysInMonth(selectedYear, selectedMonth);
    final List<int> days = List.generate(maxDay, (i) => i + 1);
    final List<int> months = List.generate(12, (i) => i + 1);
    final List<int> years = List.generate(
      maxYear - minYear + 1,
      (i) => minYear + i,
    );

    return Container(
      height: sheetHeight,
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          const SizedBox(height: 16),

          TextApp.body(widget.titleText, fontWeight: FontWeight.bold),

          const SizedBox(height: 8),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // DAY
                if (showDay)
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: dayController,
                      itemExtent: 32,
                      onSelectedItemChanged: (index) {
                        setState(() => selectedDay = days[index]);
                      },
                      children: days
                          .map((d) => Center(child: Text("$d")))
                          .toList(),
                    ),
                  ),

                // MONTH
                if (showMonth)
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: monthController,
                      itemExtent: 32,
                      onSelectedItemChanged: (index) {
                        setState(() => selectedMonth = months[index]);
                      },
                      children: monthNames
                          .map((m) => Center(child: Text(m)))
                          .toList(),
                    ),
                  ),

                // YEAR
                if (showYear)
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: yearController,
                      itemExtent: 32,
                      onSelectedItemChanged: (index) {
                        setState(() => selectedYear = years[index]);
                      },
                      children: years
                          .map((y) => Center(child: Text("$y")))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // PRIMARY BUTTON (same as your original)
          PrimaryButton(
            text: widget.buttonText,
            isEnabled: true,
            onPressed: () {
              switch (widget.type) {
                case DatePickerType.date:
                  widget.onSelected(
                    DateTime(selectedYear, selectedMonth, selectedDay),
                  );
                  break;

                case DatePickerType.monthYear:
                  widget.onSelected(DateTime(selectedYear, selectedMonth, 1));
                  break;

                case DatePickerType.year:
                  widget.onSelected(selectedYear);
                  break;

                case DatePickerType.month:
                  widget.onSelected(selectedMonth);
                  break;
              }

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
