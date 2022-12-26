import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/page/create_email.dart';
import 'package:sports_app/page/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  Widget currentWidget = const Scaffold();

  @override
  Widget build(BuildContext context) {
    return currentWidget;
  }

  @override
  void initState() {
    super.initState();
    route();
  }

  Future route() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool("first_time");
    if (firstTime != null && !firstTime) {
      setState(() {
        currentWidget = const SignIn();
      });
    } else {
      prefs.setBool("first_time", false);
      setState(() {
        currentWidget = const CreateEmail();
      });
    }
  }
}
