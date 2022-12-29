import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/wrapper.dart';
import 'package:sports_app/utils/colors.dart';
import 'package:sports_app/widget/loading_overlay.dart';

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
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.teal),
            primaryColor: Colors.teal,
            dividerColor: Colors.black,
            scaffoldBackgroundColor: AppColors.appBackgroundColor,
          ),
          home: const LoadingOverlay(child: Wrapper()),
        ),
      ),
    );
  }
}
