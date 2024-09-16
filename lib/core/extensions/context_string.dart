import 'package:flutter/material.dart';

extension StringExt on String {
  Color get hexToColor {
    // Add 'FF' for the opacity (alpha channel)
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
