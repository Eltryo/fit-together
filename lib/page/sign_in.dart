import 'package:flutter/material.dart';
import 'package:sports_app/utils/colors.dart';
import 'package:sports_app/widget/password_form_field.dart';

import '../services/auth.dart';
import '../widget/email_form_field.dart';
import '../widget/rounded_button_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                EmailFormField(emailController: emailController),
                const SizedBox(height: 10),
                PasswordFormField(passwordController: passwordController),
                const SizedBox(height: 10),
                RoundedButtonWidget(
                    text: "Submit",
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _auth.signInToAccount(
                          emailController.text, passwordController.text);
                    })
              ],
            ),
          ),
        ));
  }
}
