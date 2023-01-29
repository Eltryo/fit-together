import 'package:fit_together/services/auth.dart';
import 'package:fit_together/widgets/loading_overlay.dart';
import 'package:fit_together/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class SubmitRegistrationPage extends StatefulWidget {
  const SubmitRegistrationPage({Key? key}) : super(key: key);

  @override
  State<SubmitRegistrationPage> createState() => _SubmitRegistrationPageState();
}

class _SubmitRegistrationPageState extends State<SubmitRegistrationPage> {
  //TODO: dependency injection
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Scaffold(
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
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, _) {
                  final email = ref.watch(emailProvider);
                  final password = ref.watch(passwordProvider);
                  final username = ref.watch(usernameProvider);

                  return RoundedButton(
                    text: "Register",
                    onPressed: () async {
                      LoadingOverlay.of(context).showLoadingScreen();
                      await _auth.createAccount(email, password, username);
                      if (mounted) {
                        LoadingOverlay.of(context).hideLoadingScreen();
                        Future.delayed(const Duration(milliseconds: 500));
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
