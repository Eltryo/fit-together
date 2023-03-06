import 'package:fit_together/screens/registration_page.dart';
import 'package:fit_together/screens/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        //TODO: handle error
        if (snapshot.hasData) {
          final prefs = snapshot.data!;
          bool? firstTime = prefs.getBool("first_time");
          if (firstTime != null && !firstTime) {
            return const SignInPage();
          }
          prefs.setBool("first_time", false);
          return const RegistrationPage();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
