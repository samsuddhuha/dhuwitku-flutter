import 'dart:ui';

import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:dhuwitku/network/remotedata/main/model/select_model.dart';
import 'package:flutter/material.dart';

void showSelectBottomSheet({
  required BuildContext context,
  required dynamic items, // List<String> | List<SelectModel>
  required ValueChanged<String> onSelected,
}) {
  late final List<SelectModel> normalizedItems;

  if (items is List<SelectModel>) {
    normalizedItems = items;
  } else if (items is List<String>) {
    normalizedItems = items
        .map((e) => SelectModel(name: e, isEnable: true))
        .toList();
  } else {
    throw ArgumentError('items must be List<String> or List<SelectModel>');
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _SelectBottomSheet(items: normalizedItems, onSelected: onSelected);
    },
  );
}

class _SelectBottomSheet extends StatefulWidget {
  final List<SelectModel> items;
  final ValueChanged<String> onSelected;

  const _SelectBottomSheet({required this.items, required this.onSelected});

  @override
  State<_SelectBottomSheet> createState() => _SelectBottomSheetState();
}

class _SelectBottomSheetState extends State<_SelectBottomSheet> {
  late List<SelectModel> filteredItems;
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _onSearch(String value) {
    setState(() {
      filteredItems = widget.items
          .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white.withValues(alpha: 0.12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.surfaceGrey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 16),

              TextApp.body('Pilih', fontWeight: FontWeight.bold),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InputField(
                  title: '',
                  hintText: 'Cari',
                  leftIconPath: AppImages.icSearch,
                  controller: searchCtrl,
                  onChanged: _onSearch,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.separated(
                  itemCount: filteredItems.length,
                  separatorBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(height: 1, color: AppColors.silver),
                  ),
                  itemBuilder: (_, index) {
                    final item = filteredItems[index];
                    final isDisabled = !item.isEnable;

                    return Container(
                      color: isDisabled
                          ? AppColors.surfaceGrey
                          : Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: TextApp.small(item.name, color: AppColors.white),
                        trailing: isDisabled
                            ? TextApp.small(
                                'Tidak tersedia',
                                color: AppColors.grey,
                              )
                            : null,
                        enabled: !isDisabled,
                        onTap: isDisabled
                            ? null
                            : () {
                                Navigator.pop(context);
                                widget.onSelected(item.name);
                              },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
