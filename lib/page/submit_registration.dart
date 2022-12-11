import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/page/route_builder.dart';
import 'package:sports_app/page/wrapper.dart';
import 'package:sports_app/services/auth.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../utils/colors.dart';

class SubmitRegistration extends StatelessWidget {
  final AuthService _auth = AuthService();

  SubmitRegistration({Key? key}) : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Move on and join our ambitious community.\nShare your progress, find connections and reach your goals.",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              Consumer(builder: (context, ref, child) {
                final email = ref.watch(MyApp.emailProvider);
                final password = ref.watch(MyApp.passwordProvider);
                final username = ref.watch(MyApp.usernameProvider);

                //TODO: create user
                return RoundedButtonWidget(
                    text: "Register",
                    onPressed: () async {
                      _auth.createAccount(email, password, username);

                      Timer(const Duration(seconds: 3), () {
                        Navigator.of(context).pushReplacement(RouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const Wrapper()));
                      });
                    });
              })
            ],
          ),
        ));
  }
}
