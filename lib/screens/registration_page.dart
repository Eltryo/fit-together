import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/models/app_user.dart';
import 'package:fit_together/providers.dart';
import 'package:fit_together/widgets/loading_overlay.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
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
                      emailController,
                      passwordController,
                      usernameController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (errorMessage.isNotEmpty) buildErrorMessage(errorMessage),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitSignIn(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController usernameController,
  ) {
    debugPrint("error message will be reset");
    setState(
          () {
        errorMessage = "";
      },
    );

    //TODO: Add client side validation
    final authService = ref.read(authServiceProvider);
    authService
        .createAccount(
      emailController.text,
      passwordController.text,
      usernameController.text,
    )
        .then(
      (userCredential) {
        //TODO: fix loading screen
        LoadingOverlay.of(context).showLoadingScreen();
        final firestoreService = ref.read(firestoreServiceProvider);
        firestoreService.addUser(
          AppUser(
            uid: userCredential.user!.uid,
            username: usernameController.text,
            email: emailController.text,
          ),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
        LoadingOverlay.of(context).hideLoadingScreen();
      },
    ).onError(
      (FirebaseAuthException error, stackTrace) {
        debugPrint("error caught: ${error.message}");
        setState(
          () {
            errorMessage = error.message!;
          },
        );
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
