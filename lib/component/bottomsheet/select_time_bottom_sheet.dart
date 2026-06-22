import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSelectTimeBottomSheet({
  required BuildContext context,
  required Function(TimeOfDay time) onSelected,
  TimeOfDay? initialTime,
  String titleText = "Select Time",
  String buttonText = "Done",
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _TimePickerBottomSheet(
        onSelected: onSelected,
        initialTime: initialTime,
        titleText: titleText,
        buttonText: buttonText,
      );
    },
  );
}

class _TimePickerBottomSheet extends StatefulWidget {
  final Function(TimeOfDay time) onSelected;
  final TimeOfDay? initialTime;
  final String titleText;
  final String buttonText;

  const _TimePickerBottomSheet({
    required this.onSelected,
    this.initialTime,
    required this.titleText,
    required this.buttonText,
  });

  @override
  State<_TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<_TimePickerBottomSheet> {
  late int selectedHour;
  late int selectedMinute;

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialTime ?? TimeOfDay.now();

    selectedHour = initial.hour;
    selectedMinute = initial.minute;

    hourController = FixedExtentScrollController(initialItem: selectedHour);

    minuteController = FixedExtentScrollController(initialItem: selectedMinute);
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sheetHeight = MediaQuery.of(context).size.height * 0.5;

    final hours = List.generate(24, (i) => i);
    final minutes = List.generate(60, (i) => i);

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
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),

          const SizedBox(height: 16),

          TextApp.body(widget.titleText, fontWeight: FontWeight.bold),

          const SizedBox(height: 8),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    scrollController: hourController,
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedHour = hours[index];
                      });
                    },
                    children: hours
                        .map(
                          (h) =>
                              Center(child: Text(h.toString().padLeft(2, "0"))),
                        )
                        .toList(),
                  ),
                ),

                TextApp.body(":", fontWeight: FontWeight.bold),

                Expanded(
                  child: CupertinoPicker(
                    scrollController: minuteController,
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedMinute = minutes[index];
                      });
                    },
                    children: minutes
                        .map(
                          (m) =>
                              Center(child: Text(m.toString().padLeft(2, "0"))),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          PrimaryButton(
            text: widget.buttonText,
            isEnabled: true,
            onPressed: () {
              widget.onSelected(
                TimeOfDay(hour: selectedHour, minute: selectedMinute),
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
