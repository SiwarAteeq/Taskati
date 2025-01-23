import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/functions/textStyle.dart';
import 'package:taskati/core/model/task_model.dart';

class CompletedTask extends StatelessWidget {
  final TaskModel task;
  const CompletedTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: task.color == 0
            ? AppColor.primaryColor
            : task.color == 1
                ? AppColor.blueColor
                : AppColor.redColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: textStyle(color: AppColor.whiteColor, fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: AppColor.whiteColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${task.startTime} - ${task.endTime}',
                      style: textStyle(
                        color: AppColor.whiteColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColor.whiteColor,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Done',
              style: textStyle(color: AppColor.whiteColor, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
