import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/functions/textStyle.dart';
import 'package:taskati/features/home/home.dart';
import 'package:taskati/features/upload/upload_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    var userBox = Hive.box('user');
    bool isUploaded = userBox.get('isUploaded') ?? false;
    Future.delayed(Duration(seconds: 10), () {
      pushWithReplacement(context, isUploaded ? HomeScreen() : UploadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('./assets/images/logo.json'),
              Text('Taskati', style: textStyle(fontWeight: FontWeight.bold)),
              Text(
                'its time to get organized !!',
                style: textStyle(color: AppColor.lightColor, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
