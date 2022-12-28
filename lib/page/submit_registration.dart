import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/services/auth.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../utils/colors.dart';

class SubmitRegistration extends StatefulWidget {
  const SubmitRegistration({Key? key}) : super(key: key);

  @override
  State<SubmitRegistration> createState() => _SubmitRegistrationState();
}

class _SubmitRegistrationState extends State<SubmitRegistration> {
  final AuthService _auth = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
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
                  final email = ref.watch(MyApp.emailProvider);
                  final password = ref.watch(MyApp.passwordProvider);
                  final username = ref.watch(MyApp.usernameProvider);

                  return RoundedButtonWidget(
                      text: "Register",
                      onPressed: () async {
                        showLoadingScreen();
                        await _auth.createAccount(email, password, username);
                        if (!mounted) return;
                        Navigator.popUntil(
                            context,
                            (route) =>
                                route.isFirst); //TODO: pop with transition
                        _isLoading = false;
                      });
                })
              ],
            ),
          )),
      if (_isLoading) //TODO: extracting loading overlay
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: const Opacity(
              opacity: 0.8,
              child: ModalBarrier(
                dismissible: false,
                color: AppColors.loadingBackgroundColor,
              )),
        ),
      if (_isLoading)
        const Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        )
    ]);
  }

  void showLoadingScreen() {
    setState(() {
      _isLoading = true;
    });
  }
}
