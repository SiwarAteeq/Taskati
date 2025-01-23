// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taskati/core/functions/textStyle.dart';

class header extends StatelessWidget {
  const header(
      {super.key,
      required this.title,
      required this.widget,
      required this.txt});
  final String title;
  final Widget widget;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle(
                fontSize: 20,
              ),
            ),
            Text(
              txt,
              style: textStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Spacer(),
        widget,
      ],
    );
  }
}
