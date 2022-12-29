import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/services/auth.dart';
import 'package:sports_app/widget/loading_overlay.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../utils/colors.dart';

class SubmitRegistration extends StatefulWidget {
  const SubmitRegistration({Key? key}) : super(key: key);

  @override
  State<SubmitRegistration> createState() => _SubmitRegistrationState();
}

class _SubmitRegistrationState extends State<SubmitRegistration> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Scaffold(
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
                  "Move on and join our ambitious community.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                Consumer(builder: (context, ref, child) {
                  final email = ref.watch(emailProvider);
                  final password = ref.watch(passwordProvider);
                  final username = ref.watch(usernameProvider);

                  return RoundedButtonWidget(
                      text: "Register",
                      onPressed: () async {
                        LoadingOverlay.of(context).showLoadingScreen();
                        await _auth.createAccount(email, password, username);
                        if (!mounted) return;
                        Navigator.popUntil(
                            context,
                            (route) =>
                                route.isFirst); //TODO: pop with transition
                        LoadingOverlay.of(context).hideLoadingScreen();
                      });
                })
              ],
            ),
          )),
    );
  }
}
