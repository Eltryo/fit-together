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
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );
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
              RoundedButton(
                text: "Submit",
                onPressed: submitSignIn,
              ),
              const SizedBox(height: 10),
              if (errorMessage.isNotEmpty) buildErrorMessage(errorMessage),
            ],
          ),
        ),
      ),
    );
  }

  void submitSignIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInToAccount(
            emailController.text, passwordController.text);
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message!;
        });
      }

      return;
    }

    setState(() {
      errorMessage = "";
    });
  }

  Widget buildErrorMessage(String errorMessage) {
    _animationController.reset();
    _animationController.forward();
    //TODO: Add dropdown animation
    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Text(
          errorMessage,
          style: TextStyle(color: Theme.of(context).errorColor),
        ),
      ),
    );
  }
}
