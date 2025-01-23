import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/features/completedTask/completedTask.dart';
import 'package:taskati/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var completedTask = Hive.box('completedTask').values.toList();
    print('${completedTask} completd');

    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Task"),
        centerTitle: true,
      ),
      body: completedTask.isEmpty
          ? Center(
              child: Text(
                "No Complete Task",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: completedTask.length,
              itemBuilder: (context, index) {
                return CompletedTask(
                  task: completedTask[index],
                );
              },
            ),
    );
  }
}
