import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/widgets/password_form_field.dart';
import 'package:flutter/material.dart';

import '../widgets/email_form_field.dart';
import '../widgets/rounded_button_widget.dart';

//TODO: fix error thrown after sign in
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final authService = locator<AuthenticationService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );
  String _errorMessage = "";

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
              EmailFormField(emailController: _emailController),
              const SizedBox(height: 10),
              PasswordFormField(passwordController: _passwordController),
              const SizedBox(height: 10),
              RoundedButton(
                text: "Submit",
                onPressed: () =>
                    submitSignIn(_emailController.text, _passwordController.text),
              ),
              const SizedBox(height: 10),
              if (_errorMessage.isNotEmpty) buildErrorMessage(_errorMessage),
            ],
          ),
        ),
      ),
    );
  }

  void submitSignIn(
    String email,
    String password,
  ) {
    updateErrorMessage('');

    if (email.isEmpty) {
      return updateErrorMessage('E-mail address is required');
    }

    RegExp emailRegex = RegExp(r'\w+@\w+\.\w+');
    if (!emailRegex.hasMatch(email)) {
      return updateErrorMessage('Invalid E-mail Address format.');
    }

    if (password.isEmpty) {
      return updateErrorMessage('Password is required.');
    }

    authService.signInToAccount(email, password).catchError(
      (error) {
        updateErrorMessage(error.toString());
      },
      test: (error) => error is FirebaseAuthException,
    );
  }

  void updateErrorMessage(String errorMessage) {
    debugPrint(errorMessage);
    setState(
      () {
        _errorMessage = errorMessage;
      },
    );
  }

  Widget buildErrorMessage(String errorMessage) {
    _animationController.forward(from: 0);
    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Text(
          errorMessage,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
