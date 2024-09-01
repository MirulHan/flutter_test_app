import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  const PrimaryText(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 12.0,
    this.color = Colors.black,
    this.textAlign = TextAlign.left,
    this.overflow,
    this.decoration,
    this.maxLines,
    this.fontStyle,
    this.height,
    this.fontFamily,
    this.softWrap = true,
  });

  final String text;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final double fontSize;
  final Color? color;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final int? maxLines;
  final double? height;
  final String? fontFamily;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
        fontFamily: fontFamily,
        decoration: decoration,
      ),
    );
  }
}
