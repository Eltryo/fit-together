import 'package:flutter/material.dart';
import 'package:sports_app/services/auth.dart';
import 'package:sports_app/widget/validation_form_widget.dart';

import '../utils/colors.dart';

class EmailPasswordRegistration extends StatefulWidget {
  const EmailPasswordRegistration({Key? key}) : super(key: key);

  @override
  State<EmailPasswordRegistration> createState() =>
      _EmailPasswordRegistrationState();
}

class _EmailPasswordRegistrationState extends State<EmailPasswordRegistration> {
  final AuthService _auth = AuthService();

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
            const ValidationFormWidget(
              entry: "Registration",
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => {
                  _auth.signOut(), //TODO: find better solution
                  Navigator.pushReplacementNamed(context, "/wrapper")
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
