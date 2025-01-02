import 'package:flutter/material.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/functions/textStyle.dart';

class customButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? bgColor;
  final Color? txtColor;
  final String txt;
  final Function() onPressed;
  const customButton(
      {super.key,
      this.width = 250,
      this.height = 50,
      this.bgColor,
      this.txtColor,
      required this.txt,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? AppColor.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          txt,
          style: textStyle(
            color: txtColor ?? AppColor.whiteColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
