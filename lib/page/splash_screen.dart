import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/page/create_email.dart';
import 'package:sports_app/page/route_builder.dart';
import 'package:sports_app/page/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //TODO: fix splash screen logic
  // startTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? firstTime = prefs.getBool('first_time');
  //
  //   var duration = const Duration(seconds: 3);
  //   if (firstTime != null && !firstTime) {
  //     return Timer(duration, () {
  //       Navigator.of(context).pushReplacement(
  //           RouteBuilder(widget: const Wrapper()).buildRoute());
  //     });
  //   } else {
  //     prefs.setBool("first_time", false);
  //     return Timer(duration, () {
  //       Navigator.of(context).pushReplacement(
  //           RouteBuilder(widget: const CreateEmail()).buildRoute());
  //     });
  //   }
  // }

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

  // @override
  // void initState() {
  //   super.initState();
  //   startTime();
  // }
}
