import 'package:flutter/material.dart';
import 'package:sports_app/services/auth.dart';
import 'package:sports_app/utils/colors.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 20.0,
          ),
          child: RoundedButtonWidget(
            color: color,
            text: "sing in anonymously",
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print("error signing in");
              } else {
                print("successfully signed in ${result.uid}");
              }
            },
          )),
    );
  }
}
