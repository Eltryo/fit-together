import 'package:flutter/material.dart';
import 'package:sports_app/colors.dart';

import 'home_page.dart';

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
        scaffoldBackgroundColor: AppTheme.appBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppTheme.appTextColor,
              displayColor: AppTheme.appTextColor,
            ),
      ),
      home: const HomePage(),
    );
  }
}
