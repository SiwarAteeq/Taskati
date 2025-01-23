// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:date_picker_timeline/persian_date/persian_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/functions/textStyle.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/features/home/home.dart';
import 'package:taskati/widgets/custom_button.dart';

class addTaskScreen extends StatefulWidget {
  const addTaskScreen({super.key});

  @override
  State<addTaskScreen> createState() => _addTaskScreenState();
}

class _addTaskScreenState extends State<addTaskScreen> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  var startController =
      TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));
  var endController =
      TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(color: AppColor.whiteColor),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: textStyle(),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value != null) {
                      if (value.length < 5) return "invalid title";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Note",
                  style: textStyle(),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: noteController,
                  maxLines: 4,
                  validator: (value) {
                    if (value != null) {
                      if (value.length < 10) return "invalid note";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Date",
                  style: textStyle(),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2026))
                        .then((value) {
                      if (value != null) {
                        dateController.text =
                            DateFormat("dd/MM/yyyy").format(value);
                      }
                    });
                  },
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                    Icons.calendar_month,
                    color: AppColor.primaryColor,
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start time",
                            style: textStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  startController.text = value.format(context);
                                }
                              });
                            },
                            controller: startController,
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                              Icons.access_time_outlined,
                              color: AppColor.primaryColor,
                            )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End time",
                            style: textStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  endController.text = value.format(context);
                                }
                              });
                            },
                            controller: endController,
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                              Icons.access_time_outlined,
                              color: AppColor.primaryColor,
                            )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        3,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: index == 0
                                  ? AppColor.primaryColor
                                  : index == 1
                                      ? AppColor.blueColor
                                      : AppColor.redColor,
                              child: selectedColor == index
                                  ? Icon(
                                      Icons.check,
                                      color: AppColor.whiteColor,
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    customButton(
                        txt: "Create Task",
                        width: 150,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (endController.text[1] == ':')
                              endController.text = '0' + endController.text;
                            if (startController.text[1] == ':')
                              startController.text = '0' + startController.text;
                            int eHour = int.parse(
                                endController.text[0] + endController.text[1]);
                            int esec = int.parse(
                                endController.text[3] + endController.text[4]);
                            int sHour = int.parse(startController.text[0] +
                                startController.text[1]);
                            int ssec = int.parse(startController.text[3] +
                                startController.text[4]);
                            if (endController.text[6] == 'P' && eHour < 12)
                              eHour += 12;
                            if (startController.text[6] == 'P' && sHour < 12)
                              sHour += 12;
                            if (eHour < sHour ||
                                (eHour == sHour && esec <= ssec)) {
                              const snackBar = SnackBar(
                                content: Text(
                                  'End time must more than start time!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              TaskModel newTask = TaskModel(
                                  id: DateTime.now().toString() +
                                      titleController.text,
                                  title: titleController.text,
                                  note: noteController.text,
                                  date: dateController.text,
                                  startTime: startController.text,
                                  endTime: endController.text,
                                  color: selectedColor,
                                  isCompleted: false);
                              var taskBox = Hive.box("task");
                              taskBox.put(newTask.id, newTask);
                              pushWithReplacement(context, HomeScreen());
                            }
                            ;
                          }
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
