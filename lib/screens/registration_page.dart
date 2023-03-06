import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/widgets/password_form_field.dart';
import 'package:fit_together/widgets/username_form_field.dart';
import 'package:flutter/material.dart';

import '../widgets/email_form_field.dart';
import '../widgets/rounded_button_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
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
                "Registration",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              EmailFormField(emailController: _emailController),
              const SizedBox(height: 10),
              PasswordFormField(passwordController: _passwordController),
              const SizedBox(height: 10),
              UsernameFormField(usernameController: _usernameController),
              const SizedBox(height: 10),
              RoundedButton(
                text: "Register",
                onPressed: () => submitSignIn(
                  _emailController.text,
                  _passwordController.text,
                  _usernameController.text,
                ),
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
    String username,
  ) {
    updateErrorMessage('');

    if (email.isEmpty) {
      return updateErrorMessage('E-mail address is required');
    }

    RegExp emailRegex = RegExp(r'\w+@\w+\.\w+');
    if (!emailRegex.hasMatch(email)) {
      return updateErrorMessage('Invalid E-mail address format');
    }

    if (password.isEmpty) {
      return updateErrorMessage('Password is required');
    }

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      return updateErrorMessage(
          'Password must be at least 8 characters, include an uppercase letter, number and symbol.');
    }

    final authService = locator<AuthenticationService>();
    authService
        .createAccount(
      _emailController.text,
      _passwordController.text,
      _usernameController.text,
    )
        .catchError(
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
    _animationController.reset();
    _animationController.forward();
    debugPrint("Animation was started");

    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
