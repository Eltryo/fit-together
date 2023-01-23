import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/widgets/password_form_field.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../widgets/email_form_field.dart';
import '../widgets/rounded_button_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final AnimationController _animationController = AnimationController(
      duration: const Duration(milliseconds: 500), vsync: this);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
  String errorMessage = "";

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            //TODO: Add fade animation
            FadeTransition(
                opacity: _animation,
                child: Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                )),
            const SizedBox(height: 10),
            RoundedButton(
                text: "Submit",
                onPressed: () async {
                  errorMessage = "";
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _auth.signInToAccount(
                          emailController.text, passwordController.text);
                    } on FirebaseAuthException catch (e) {
                      errorMessage = e.message!;
                    }
                  }

                  setState(() {});
                })
          ],
        ),
      ),
    ));
  }
}
