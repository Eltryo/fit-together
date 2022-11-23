import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/page/email_password_registration.dart';
import 'package:sports_app/page/route_builder.dart';
import 'package:sports_app/page/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    var duration = const Duration(seconds: 3);
    if (firstTime != null && !firstTime) {
      return Timer(duration, () {
        Navigator.of(context).pushReplacement(RouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Wrapper()));
      });
    } else {
      prefs.setBool("first_time", false);
      return Timer(duration, () {
        Navigator.of(context).pushReplacement(RouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const EmailPasswordRegistration()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "lib/images/fit_together_logo.png",
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
}