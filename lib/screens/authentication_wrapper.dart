import 'package:fit_together/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  Widget currentWidget = const Scaffold();

  @override
  Widget build(BuildContext context) {
    return currentWidget;
  }

  @override
  void initState() {
    super.initState();
    routeToAuthenticationPage();
  }

  void routeToAuthenticationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool("first_time");
    if (firstTime != null && !firstTime) {
      setState(() {
        currentWidget = const RegistrationPage();
      });
    } else {
      prefs.setBool("first_time", false);
      setState(() {
        currentWidget = const RegistrationPage();
      });
    }
  }
}
