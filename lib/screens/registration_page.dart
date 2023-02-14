import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/models/app_user.dart';
import 'package:fit_together/providers.dart';
import 'package:fit_together/widgets/password_form_field.dart';
import 'package:fit_together/widgets/username_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/email_form_field.dart';
import '../widgets/rounded_button_widget.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
              EmailFormField(emailController: emailController),
              const SizedBox(height: 10),
              PasswordFormField(passwordController: passwordController),
              const SizedBox(height: 10),
              UsernameFormField(usernameController: usernameController),
              const SizedBox(height: 10),
              RoundedButton(
                text: "Register",
                onPressed: () => submitSignIn(
                  emailController.text,
                  passwordController.text,
                  usernameController.text,
                ),
              ),
              const SizedBox(height: 10),
              if (errorMessage.isNotEmpty) buildErrorMessage(errorMessage),
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
      updateErrorMessage('E-mail address is required');
      return;
    }

    RegExp emailRegex = RegExp(r'\w+@\w+\.\w+');
    if (!emailRegex.hasMatch(email)) {
      updateErrorMessage('Invalid E-mail address format');
      return;
    }

    if (password.isEmpty) {
      updateErrorMessage('Password is required');
      return;
    }

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      updateErrorMessage(
          'Password must be at least 8 characters, include an uppercase letter, number and symbol.');
      return;
    }

    final authService = ref.read(authServiceProvider);
    authService
        .createAccount(
      emailController.text,
      passwordController.text,
      usernameController.text,
    )
        .then(
      (userCredential) {
        final firestoreService = ref.read(firestoreServiceProvider);
        firestoreService.addUser(
          AppUser(
            uid: userCredential.user!.uid,
            username: usernameController.text,
            email: emailController.text,
          ),
        );
      },
    ).catchError((error) {
      updateErrorMessage(error.message!);
    }, test: (error) => error is FirebaseAuthException);
  }

  void updateErrorMessage(String errorMessage) {
    debugPrint(errorMessage);
    setState(
      () {
        this.errorMessage = errorMessage;
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
