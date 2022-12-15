import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/splash_screen.dart';
import 'package:sports_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // static final authServiceProvider =
  //     StreamProvider<AuthUser?>((ref) => AuthService().user);
  static final emailProvider = StateProvider<String>((ref) => "");
  static final passwordProvider = StateProvider((ref) => "");
  static final usernameProvider = StateProvider((ref) => "");

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
            primaryColor: Colors.teal,
            dividerColor: Colors.black,
            scaffoldBackgroundColor: AppColors.appBackgroundColor,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
