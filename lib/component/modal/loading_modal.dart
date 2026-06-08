import 'package:flutter/material.dart';

class LoadingModal {
  static OverlayEntry? _currentOverlay;

  static void show(BuildContext context, {String? message}) {
    if (_currentOverlay != null) return;

    _currentOverlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          ModalBarrier(
            color: Colors.black45,
            dismissible: false,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Colors.white),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_currentOverlay!);
  }

  static void hide() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
