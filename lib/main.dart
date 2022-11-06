import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/page/email_password_registration.dart';
import 'package:sports_app/page/routes/edit_profile.dart';
import 'package:sports_app/screens/wrapper.dart';
import 'package:sports_app/services/auth.dart';
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
    return StreamProvider.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: "fit-together",
        theme: ThemeData(
          primaryColor: Colors.teal,
          dividerColor: Colors.black,
          scaffoldBackgroundColor: AppColors.appBackgroundColor,
        ),
        // home: const Wrapper(),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/edit_profile': (context) => const EditProfile(),
          '/email_password_registration': (context) => const EmailPasswordRegistration(),
        },
      ),
    );
  }
}
