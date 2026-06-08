import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/core/ui/text_app.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final bool isWhite;

  const Navbar({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.isWhite = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isWhite ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,

      child: Container(
        color: backgroundColor,

        child: SafeArea(
          bottom: false,

          child: SizedBox(
            height: 52,

            child: Stack(
              alignment: Alignment.center,

              children: [
                Positioned(
                  left: 16,

                  child: GestureDetector(
                    onTap: onPressed ?? () => Navigator.pop(context),

                    child: Image.asset(
                      AppImages.icArrowLeft,
                      width: 24,
                      height: 24,
                      color: isWhite ? Colors.white : null,
                    ),
                  ),
                ),

                TextApp.body(
                  title,
                  fontWeight: FontWeight.w600,
                  color: isWhite ? Colors.white : Colors.black,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
