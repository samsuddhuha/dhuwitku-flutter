import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool isDesktopWeb(BuildContext context) {
  if (!kIsWeb) return false;

  return MediaQuery.of(context).size.width >= 600;
}
