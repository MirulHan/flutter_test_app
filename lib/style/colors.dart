import 'package:flutter/material.dart';

class AppColors {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static final Color blue = fromHex('#0077B6');
  static final Color lightblue = fromHex('#B3E5FC');
  static final Color darkBlue = fromHex('#005f99');
  static final Color white = fromHex('#FFFFFF');
  static final Color black = fromHex('#000000');
  static final Color lightblack = fromHex('#060326');
  static final Color darkGray = fromHex('#CCCCCC');
  static final Color lightGray = fromHex('#EBEBEB');
  static final Color red = fromHex('#ED1C2E');
}
