import 'package:flutter/material.dart';
import 'package:sports_app/screens/wrapper.dart';
import 'package:sports_app/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fit-together",
      theme: ThemeData(
        primaryColor: Colors.teal,
        dividerColor: Colors.black,
        scaffoldBackgroundColor: AppColors.appBackgroundColor,
      ),
      home: const Wrapper(),
    );
  }
}
