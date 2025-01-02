// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/functions/textStyle.dart';
import 'package:taskati/features/home/home.dart';
import 'package:taskati/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate() && path != null)
                  pushWithReplacement(context, HomeScreen());
                else if (path == null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Error",
                            style: textStyle(fontSize: 20),
                          ),
                          content: Text("please upload image"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"))
                          ],
                        );
                      });
                } else
                  print("error");
              },
              child: Text(
                "Done",
                style: textStyle(color: AppColor.primaryColor, fontSize: 16),
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: path != null ? FileImage(File(path!)) : null,
              ),
              SizedBox(
                height: 18,
              ),
              customButton(
                txt: "Upload from Camera",
                onPressed: () async {
                  final XFile? photo = await ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then((value) {
                    if (value != null)
                      setState(() {
                        path = value.path;
                      });
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              customButton(
                txt: "Upload from Gallery",
                onPressed: () async {
                  final XFile? photo = await ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value != null)
                      setState(() {
                        path = value.path;
                      });
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: AppColor.primaryColor,
                indent: 20,
                endIndent: 20,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "name is required";
                    } else if (value.length < 3) return "liss than 3";
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name ...",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
