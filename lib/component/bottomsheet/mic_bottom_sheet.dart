import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/feature/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showMicBottomSheet({
  required BuildContext context,
  required HomeVm vm,
  bool? isDismissible,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: isDismissible ?? true,
    isScrollControlled: true,
    enableDrag: isDismissible ?? true,
    backgroundColor: const Color.fromARGB(0, 3, 2, 2),
    builder: (_) {
      return ChangeNotifierProvider<HomeVm>.value(
        value: vm,
        child: Consumer<HomeVm>(
          builder: (context, vm, _) {
            return Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 48,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceGrey,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title + Close
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextApp.h5(
                            'Catat dengan Suara',
                            fontWeight: FontWeight.bold,
                            color: AppColors.tundora,
                          ),
                          const SizedBox(height: 4),
                          TextApp.small(
                            'Stop otomatis saat kamu berhenti berbicara',
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          vm.stopListening();
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Mic button
                  GestureDetector(
                    onTap: () {
                      if (vm.isListening) {
                        print('tesssss');
                        vm.stopListening();
                      } else {
                        print('tesssss2');
                        vm.onTapMic();
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: vm.isListening
                            ? AppColors.crimsonRed
                            : AppColors.primaryDark,
                      ),
                      child: Icon(
                        vm.isListening ? Icons.stop : Icons.mic,
                        color: AppColors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextApp.small(
                    vm.isListening ? 'Menyimak...' : 'Tekan untuk mulai bicara',
                    color: AppColors.grey,
                  ),
                  const SizedBox(height: 24),

                  // Text hasil
                  InputField(
                    title: '',
                    hintText: 'Text akan muncul di sini...',
                    controller: TextEditingController(text: vm.speechText),
                    enabled: true,
                    minLines: 2,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),

                  // Tombol simpan
                  if (vm.speechText.isNotEmpty && !vm.isListening)
                    PrimaryButton(
                      text: 'Simpan',
                      isEnabled: true,
                      onPressed: () {
                        vm.parserDataFromText();
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
