import 'package:flutter/material.dart';
import 'package:sports_app/colors.dart';

import 'app_tab_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      theme: ThemeData(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: AppColors.appBackgroundColor,
      ),
      home: const AppTabController(),
    );
  }
}
