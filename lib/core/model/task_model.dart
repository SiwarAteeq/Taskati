import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String note;
  String date;
  String startTime;
  String endTime;
  int color;
  bool isCompleted;
  TaskModel({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.isCompleted,
  });
  bool getIsCompleted() {
    return isCompleted;
  }
}
