import 'package:fit_together/screens/registration_page.dart';
import 'package:fit_together/screens/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  Widget? _currentWidget;

  @override
  Widget build(BuildContext context) {
    return _currentWidget?? const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    buildAuthenticationPage();
  }

  void buildAuthenticationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool("first_time");
    if (firstTime != null && !firstTime) {
      setState(
        () {
          _currentWidget = const RegistrationPage();
        },
      );
    } else {
      prefs.setBool("first_time", false);
      setState(
        () {
          _currentWidget = const RegistrationPage();
        },
      );
    }
  }
}
