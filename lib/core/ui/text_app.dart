import 'package:flutter/material.dart';

enum AppTextStyle { h1, h2, h3, h4, h5, h6, body, small, xSmall, verySmall }

class TextApp extends StatelessWidget {
  final String text;
  final AppTextStyle style;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final double? letterSpacing;

  const TextApp.h1(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.h1;

  const TextApp.h2(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.h2;

  const TextApp.h3(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.h3;

  const TextApp.h4(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.h4;

  const TextApp.h5(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.h5;

  const TextApp.h6(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.h6;

  const TextApp.body(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.body;

  const TextApp.small(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.small;

  const TextApp.xSmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.xSmall;

  const TextApp.verySmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyle.verySmall;

  // ---------- Font Size Handler ----------
  double _getFontSize(BuildContext context) {
    switch (style) {
      case AppTextStyle.h1:
        return 32;
      case AppTextStyle.h2:
        return 28;
      case AppTextStyle.h3:
        return 24;
      case AppTextStyle.h4:
        return 20;
      case AppTextStyle.h5:
        return 18;
      case AppTextStyle.h6:
        return 16;
      case AppTextStyle.body:
        return 16;
      case AppTextStyle.small:
        return 14;
      case AppTextStyle.xSmall:
        return 12;
      case AppTextStyle.verySmall:
        return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: _getFontSize(context),
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.white,
        height: height ?? 1.2,
        letterSpacing: letterSpacing ?? 0.25,
        fontFamily: "HostGrotesk",
      ),
    );
  }
}
