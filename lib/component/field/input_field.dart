import 'dart:ui';

import 'package:dhuwitku/core/ui/app_colors.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool readOnly;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;

  final String? rightIconPath;
  final VoidCallback? onTap;

  final String? leftIconPath;

  final int minLines;
  final int maxLines;

  final int? maxLength;
  final bool showCounter;

  const InputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    this.rightIconPath,
    this.onTap,
    this.leftIconPath,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.showCounter = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;

    // listen jika pakai counter
    widget.controller.addListener(() {
      if (widget.showCounter) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError =
        widget.errorText != null && widget.errorText!.isNotEmpty;

    // Color borderColor = hasError ? AppColors.error : AppColors.surfaceGrey;

    Widget? prefixIcon;
    BoxConstraints? prefixConstraints;

    if (widget.leftIconPath != null) {
      prefixIcon = Padding(
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: Image.asset(
          widget.leftIconPath!,
          width: 20,
          height: 20,
          color: AppColors.white,
        ),
      );
      prefixConstraints = const BoxConstraints(maxHeight: 20, maxWidth: 40);
    }

    Widget? suffixIcon;
    BoxConstraints? suffixConstraints;

    if (widget.obscureText) {
      suffixIcon = IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off : Icons.visibility,
          color: const Color(0xFF8D8D8D),
          size: 20,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      );
    } else if (widget.rightIconPath != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Image.asset(
          widget.rightIconPath!,
          width: 20,
          height: 20,
          color: AppColors.white,
        ),
      );
      suffixConstraints = const BoxConstraints(maxHeight: 20, maxWidth: 40);
    }

    Widget? counterWidget;
    if (widget.showCounter && widget.maxLength != null) {
      counterWidget = TextApp.xSmall(
        "${widget.controller.text.length}/${widget.maxLength}",
        color: Colors.grey,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty) ...[
          TextApp.xSmall(widget.title),
          const SizedBox(height: 6),
        ],

        ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                // glass color
                color: Colors.white.withOpacity(0.08),

                // glass border
                border: Border.all(
                  color: Colors.white.withOpacity(0.18),
                  width: 1.2,
                ),

                // soft shadow
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: TextField(
                controller: widget.controller,
                obscureText: _obscure,
                keyboardType: widget.keyboardType,
                onChanged: widget.onChanged,
                readOnly: widget.onTap != null || widget.readOnly,
                onTap: widget.onTap,
                enabled: widget.enabled,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength, // include maxlength
                textAlign: widget.textAlign,
                buildCounter:
                    (
                      _, {
                      required currentLength,
                      required isFocused,
                      maxLength,
                    }) {
                      return const SizedBox.shrink(); // disable default counter
                    },
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: (widget.enabled || widget.readOnly)
                      ? AppColors.white
                      : AppColors.white,
                  fontWeight: widget.fontWeight,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: widget.fontSize,
                    color: AppColors.lightGrey,
                    fontWeight: widget.fontWeight,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: widget.maxLines > 1 ? 12 : 14,
                  ),
                  filled: true,
                  // fillColor: widget.enabled
                  //     ? AppColors.surfaceGrey
                  //     : AppColors.surfaceGrey,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,

                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: BorderSide(color: borderColor),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: const BorderSide(
                  //     color: AppColors.secondary,
                  //     width: 1,
                  //   ),
                  // ),
                  // errorBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: const BorderSide(color: AppColors.error),
                  // ),
                  // focusedErrorBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: const BorderSide(color: AppColors.error),
                  // ),
                  // disabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: BorderSide(
                  //     color: AppColors.surfaceGrey.withValues(alpha: 0.6),
                  //   ),
                  // ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  prefixIcon: prefixIcon,
                  prefixIconConstraints: prefixConstraints,
                  suffixIcon: suffixIcon,
                  suffixIconConstraints: suffixConstraints,
                ),
              ),
            ),
          ),
        ),

        // ROW ERROR + COUNTER
        if (hasError || counterWidget != null) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Error
              if (hasError)
                Row(
                  children: [
                    // Image.asset(icInfoCircle, width: 16, height: 16),
                    // const SizedBox(width: 4),
                    TextApp.xSmall(widget.errorText!, color: AppColors.error),
                  ],
                )
              else
                const SizedBox(), // placeholder biar spacing rapi
              // Counter
              if (counterWidget != null) counterWidget,
            ],
          ),
        ],
      ],
    );
  }
}
