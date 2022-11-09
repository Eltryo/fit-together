import 'package:flutter/material.dart';
import 'package:sports_app/widget/validation_form_widget.dart';

import '../utils/colors.dart';

class EmailPasswordRegistration extends StatefulWidget {
  const EmailPasswordRegistration({Key? key}) : super(key: key);

  @override
  State<EmailPasswordRegistration> createState() =>
      _EmailPasswordRegistrationState();
}

class _EmailPasswordRegistrationState extends State<EmailPasswordRegistration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ValidationFormWidget(
                entry: "Registration",
                emailController: emailController,
                passwordController: passwordController),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign in",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            )
          ]),
        ));
  }
}
