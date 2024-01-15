import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/application/firestore.dart';
import 'package:fit_together/domain/app_user.dart';
import 'package:fit_together/presentation/auth/password_form_field.dart';
import 'package:fit_together/presentation/auth/username_form_field.dart';
import 'package:fit_together/service_locator.dart';
import 'package:flutter/material.dart';

import 'email_form_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with TickerProviderStateMixin {
  late AuthenticationService _authService;
  late FirestoreService _firestoreService;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late String _errorMessage;

  @override
  void initState() {
    _authService = locator<AuthenticationService>();
    _firestoreService = locator<FirestoreService>();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _errorMessage = '';
  }

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
              ElevatedButton(
                onPressed: () => submitSignIn(
                  _emailController.text,
                  _passwordController.text,
                  _usernameController.text,
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Register",
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
    String username,
  ) {
    updateErrorMessage('');

    if (email.isEmpty) return updateErrorMessage('E-mail address is required');

    RegExp emailRegex =
        RegExp(r'^[A-Za-z\d._%+-]+@[A-Za-z\d.-]+\.[A-Za-z]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return updateErrorMessage('Invalid E-mail address format');
    }

    if (password.isEmpty) return updateErrorMessage('Password is required');

    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#$&*~]).{8,}$');
    if (!passwordRegex.hasMatch(password)) {
      return updateErrorMessage(
        'Password must be at least 8 characters, include an uppercase letter, number and symbol.',
      );
    }

    if (username.isEmpty) return updateErrorMessage('Username is required');

    RegExp usernameRegex = RegExp(r'^[A-Za-z]\w{7,29}$');
    if (!usernameRegex.hasMatch(username)) {
      return updateErrorMessage(
          'Username must be at least 8 characters, no special characters and should not start with an underscore');
    }

    try {
      _authService
          .createAccount(
            _emailController.text,
            _passwordController.text,
            _usernameController.text,
          )
          .then((credentials) => {
                _firestoreService.addUser(EmailUsernameDto(
                    username: credentials.user!.uid,
                    email: credentials.user!.email))
              });
    } on FirebaseAuthException catch (e) {
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
