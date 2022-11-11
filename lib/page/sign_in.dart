import 'package:flutter/material.dart';
import 'package:sports_app/utils/colors.dart';
import 'package:sports_app/widget/validation_form_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 20.0,
          ),
          child: const ValidationFormWidget(
            entry: "Login",
          )),
    );
  }
}
