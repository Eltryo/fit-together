import 'package:flutter/material.dart';
import 'package:sports_app/assets/colors.dart';

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
          scaffoldBackgroundColor: AppTheme.whiteBackgroundColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: AppTheme.blackAppTextColor,
                displayColor: AppTheme.blackAppTextColor,
              ),
          appBarTheme: const AppBarTheme(
              backgroundColor: AppTheme.whiteBackgroundColor,
              titleTextStyle: TextStyle(
                  color: AppTheme.blackAppTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500))),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App"),
        elevation: 0,
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}
