import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/screens/wrapper.dart';
import 'package:sports_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
