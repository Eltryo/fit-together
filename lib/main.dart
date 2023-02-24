import 'package:firebase_core/firebase_core.dart';
import 'package:fit_together/screens/entry_wrapper.dart';
import 'package:fit_together/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: "fit-together",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.black,
              ),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            indicatorColor: Colors.teal,
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.teal),
            dividerColor: Colors.black,
          ),
          home: const EntryWrapper(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
