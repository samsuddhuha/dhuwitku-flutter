import 'package:dhuwitku/component/field/input_field.dart';
import 'package:flutter/material.dart';

class InputDropdown extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final List<String> items;
  final ValueChanged<String>? onSelected;
  final String? errorText;
  final bool enabled;
  final String? leftIconPath;
  final String? rightIconPath;

  const InputDropdown({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.items,
    this.onSelected,
    this.errorText,
    this.enabled = true,
    this.leftIconPath,
    this.rightIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MenuAnchor(
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            elevation: WidgetStatePropertyAll(2),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          menuChildren: items.map((item) {
            return SizedBox(
              width: constraints.maxWidth,
              child: MenuItemButton(
                onPressed: () {
                  controller.text = item;
                  onSelected?.call(item);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(item),
                ),
              ),
            );
          }).toList(),

          // menuChildren: items.map((item) {
          //   final bool isSelected = controller.text == item;

          //   return SizedBox(
          //     width: constraints.maxWidth,
          //     child: MenuItemButton(
          //       onPressed: () {
          //         controller.text = item;
          //         onSelected?.call(item);
          //       },
          //       style: ButtonStyle(
          //         backgroundColor: WidgetStatePropertyAll(
          //           isSelected
          //               ? AppColors.secondary.withValues(alpha: 0.1)
          //               : Colors.white,
          //         ),
          //       ),
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: Text(
          //               item,
          //               style: TextStyle(
          //                 color: isSelected
          //                     ? AppColors.secondary
          //                     : AppColors.textPrimary,
          //                 fontWeight: isSelected
          //                     ? FontWeight.w600
          //                     : FontWeight.w400,
          //               ),
          //             ),
          //           ),

          //           if (isSelected)
          //             Icon(Icons.check, size: 18, color: AppColors.secondary),
          //         ],
          //       ),
          //     ),
          //   );
          // }).toList(),
          builder: (context, menuController, child) {
            return InputField(
              title: title,
              hintText: hintText,
              controller: controller,
              errorText: errorText,
              enabled: enabled,
              leftIconPath: leftIconPath,
              rightIconPath: rightIconPath,
              onTap: () {
                if (menuController.isOpen) {
                  menuController.close();
                } else {
                  menuController.open();
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
            );
          },
        );
      },
    );
  }
}
