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
    this.fontSize = 14,
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

  final FocusNode _focusNode = FocusNode();

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

    Color borderColor = hasError ? AppColors.error : AppColors.silver;
    Color focusedBorderColor = hasError ? AppColors.error : AppColors.secondary;

    Widget? prefixIcon;
    BoxConstraints? prefixConstraints;

    if (widget.leftIconPath != null) {
      prefixIcon = Padding(
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: Image.asset(widget.leftIconPath!, width: 20, height: 20),
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
        child: Image.asset(widget.rightIconPath!, width: 20, height: 20),
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
          TextApp.small(
            widget.title,
            color: AppColors.tundora,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 6),
        ],

        TextField(
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          onTap: () {
            if (widget.readOnly) {
              _focusNode.unfocus();
            }

            FocusManager.instance.primaryFocus?.unfocus();
            widget.onTap?.call();
          },
          enabled: widget.enabled,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength, // include maxlength
          textAlign: widget.textAlign,
          buildCounter:
              (_, {required currentLength, required isFocused, maxLength}) {
                return const SizedBox.shrink(); // disable default counter
              },
          style: TextStyle(
            fontSize: widget.fontSize,
            color: (widget.enabled || widget.readOnly)
                ? AppColors.textPrimary
                : AppColors.grey,
            fontWeight: widget.fontWeight,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: widget.fontSize,
              color: AppColors.grey,
              fontWeight: widget.fontWeight,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: widget.maxLines > 1 ? 12 : 14,
            ),
            filled: true,
            fillColor: widget.enabled ? AppColors.white : AppColors.surfaceGrey,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: focusedBorderColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.surfaceGrey.withValues(alpha: 0.6),
              ),
            ),

            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixConstraints,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixConstraints,
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
