// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/functions/textStyle.dart';
import 'package:taskati/features/AddTask/addTaskScreen.dart';
import 'package:taskati/features/completedTask/CompletedTaskScreen.dart';
import 'package:taskati/features/completedTask/completedTask.dart';
import 'package:taskati/features/upload/upload_screen.dart';
import 'package:taskati/widgets/custom_button.dart';
import 'package:taskati/widgets/header.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedValue = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box("user");
    String name = userBox.get("name");
    String path = userBox.get("image");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              header(
                title: 'Hello ${name}',
                widget: GestureDetector(
                  onTap: () {
                    pushWithReplacement(context, UploadScreen());
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: FileImage(File(path)),
                  ),
                ),
                txt: "Have a Nice Day!",
              ),
              SizedBox(
                height: 20,
              ),
              header(
                title: DateFormat.yMMMd().format(DateTime.now()).toString(),
                widget: customButton(
                    txt: "+Add Task",
                    width: 130,
                    onPressed: () {
                      pushTo(context, addTaskScreen());
                    }),
                txt: "Today",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customButton(
                    txt: "CompletTask",
                    onPressed: () {
                      pushTo(context, CompletedTaskScreen());
                    },
                    width: 140,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DatePicker(
                DateTime.now(),
                width: 80,
                height: 100,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColor.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  print(date.toString());
                  setState(() {
                    selectedValue = DateFormat('dd/MM/yyyy').format(date);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: Hive.box("task").listenable(),
                builder: (context, Box boxTask, child) {
                  var taskss = boxTask.values.toList();
                  var tasks = taskss
                      .where((element) => (element.date) == selectedValue)
                      .toList();
                  print(selectedValue);
                  print(taskss[0].date);
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            var completed = Hive.box("completedTask");
                            var task = tasks[index];
                            task.isCompleted = true;
                            String id = DateTime.now().toString() + task.title;

                            completed.put(id,
                                task); // Use an integer key instead of context
                          }
                          boxTask.deleteAt(index);
                        },
                        background: Container(
                          decoration: BoxDecoration(
                              color: AppColor.greenColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: AppColor.whiteColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Completed",
                                style: textStyle(
                                    color: AppColor.whiteColor, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          decoration: BoxDecoration(
                              color: AppColor.redColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete,
                                color: AppColor.whiteColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Delete",
                                style: textStyle(
                                    color: AppColor.whiteColor, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        key: UniqueKey(),
                        child: task_item(
                          task: tasks[index],
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
