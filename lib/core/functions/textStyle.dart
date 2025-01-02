import 'package:flutter/material.dart';
import 'package:taskati/core/colors.dart';

textStyle({double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? AppColor.primaryColor,
    fontSize: fontSize ?? 30,
    fontWeight: fontWeight ?? FontWeight.w500,
  );
}
