import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/providers.dart';
import 'package:fit_together/widgets/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/email_form_field.dart';
import '../widgets/rounded_button_widget.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                onPressed: () =>
                    submitSignIn(emailController.text, passwordController.text),
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
  ) {
    updateErrorMessage('');

    if (email.isEmpty) {
      updateErrorMessage('E-mail address is required');
      return;
    }

    RegExp emailRegex = RegExp(r'\w+@\w+\.\w+');
    if (!emailRegex.hasMatch(email)) {
      updateErrorMessage('Invalid E-mail Address format.');
      return;
    }

    if (password.isEmpty) {
      updateErrorMessage('Password is required.');
      return;
    }

    final authService = ref.read(authServiceProvider);
    authService
        .signInToAccount(email, password)
        .then((value) => null)
        .catchError(
      (error, _) {
        updateErrorMessage(error.message!);
      },
      test: (error) => error is FirebaseAuthException,
    );
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
          style: TextStyle(color: Theme.of(context).errorColor),
        ),
      ),
    );
  }
}
