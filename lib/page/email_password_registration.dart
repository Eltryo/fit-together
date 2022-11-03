import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../utils/colors.dart';

class EmailPasswordRegistration extends StatefulWidget {
  const EmailPasswordRegistration({Key? key}) : super(key: key);

  @override
  State<EmailPasswordRegistration> createState() =>
      _EmailPasswordRegistrationState();
}

class _EmailPasswordRegistrationState extends State<EmailPasswordRegistration> {
  final _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a username";
                      }
                      return null;
                    },
                  ),
                  RoundedButtonWidget(
                      text: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Processing Data")));
                        }
                      })
                ],
              ),
            )));
  }
}
