import 'package:flutter/material.dart';
// export 'package:flutter_screenutil/flutter_screenutil.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

Text regularText(String text,
    {Color? color,
    double? fontSize = 14,
    double? letterSpacing,
    Key? key,
    double? height,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    bool blur = false}) {
  return Text(
    text,
    key: key,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: true,
    style: TextStyle(
      color: color,
      letterSpacing: letterSpacing,
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
      decoration: decoration,
    ),
  );
}
