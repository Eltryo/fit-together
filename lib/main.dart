import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_together/screens/wrapper.dart';
import 'package:fit_together/widgets/loading_overlay.dart';

void main() async {
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
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            errorColor: Colors.red[700],
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.teal),
            primaryColor: Colors.teal,
            dividerColor: Colors.black,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const LoadingOverlay(child: Wrapper()),
        ),
      ),
    );
  }
}
