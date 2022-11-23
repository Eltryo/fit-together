import 'package:flutter/material.dart';
import 'package:sports_app/page/email_password_registration.dart';
import 'package:sports_app/page/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return const EmailPasswordRegistration();
  }
}
