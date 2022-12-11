import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/create_email.dart';
import 'package:sports_app/page/edit_profile.dart';
import 'package:sports_app/page/splash_screen.dart';
import 'package:sports_app/page/wrapper.dart';
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
    return ProviderScope(
      // providers: [
      //   StreamProvider(create: (_) => AuthService().user, initialData: null),
      // ],
      child: MaterialApp(
        title: "fit-together",
        theme: ThemeData(
          primaryColor: Colors.teal,
          dividerColor: Colors.black,
          scaffoldBackgroundColor: AppColors.appBackgroundColor,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
