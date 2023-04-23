import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/presentation/auth/password_form_field.dart';
import 'package:fit_together/service_locator.dart';
import 'package:flutter/material.dart';

import 'email_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  late AuthenticationService _authService;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  var _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _authService = locator<AuthenticationService>();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

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
              ElevatedButton(
                onPressed: () => submitSignIn(
                  _emailController.text,
                  _passwordController.text,
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
  ) {
    if (email.isEmpty) return updateErrorMessage('E-mail address is required');

    RegExp emailRegex = RegExp(r'\w+@\w+\.\w+');
    if (!emailRegex.hasMatch(email)) {
      return updateErrorMessage('Invalid E-mail Address format.');
    }

    if (password.isEmpty) return updateErrorMessage('Password is required.');

    updateErrorMessage('');

    try{
      _authService.signInToAccount(email, password);
    } on FirebaseAuthException catch(e){
      updateErrorMessage(e.toString());
    }
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
