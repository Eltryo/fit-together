import 'package:flutter/material.dart';
import 'package:sports_app/services/auth.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../utils/colors.dart';

class EmailPasswordRegistration extends StatefulWidget {
  const EmailPasswordRegistration({Key? key}) : super(key: key);

  @override
  State<EmailPasswordRegistration> createState() =>
      _EmailPasswordRegistrationState();
}

class _EmailPasswordRegistrationState extends State<EmailPasswordRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                      "Registration",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                  ),

                  const SizedBox(height: 10),

                  //form field for email
                  buildTextFormField("email", emailController),

                  const SizedBox(height: 10),

                  //form field for password
                  buildTextFormField("password", passwordController),

                  const SizedBox(height: 10),

                  RoundedButtonWidget(
                      text: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Processing Data")));
                        }

                        _auth.createAccount(emailController.text, passwordController.text);
                      })
                ],
              ),
            )));
  }

  TextFormField buildTextFormField(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (value) { //TODO: customize validator for each TextFormField
        if (value == null || value.isEmpty) {
          return "Please enter a $hint";
        }
        return null;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Enter your $hint",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }
}
