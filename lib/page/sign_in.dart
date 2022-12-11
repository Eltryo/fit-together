import 'package:flutter/material.dart';
import 'package:sports_app/utils/colors.dart';

import '../services/auth.dart';
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
  bool _passwordVisible = false;

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

                //form field for email
                buildEmailFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                //form field for password
                buildPasswordFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                RoundedButtonWidget(
                    text: "Submit",
                    onPressed: () {
                      _auth.signInToAccount(
                          emailController.text, passwordController.text);
                    })
              ],
            ),
          ),
        ));
  }

  //TODO: fix code repetition
  TextFormField buildPasswordFormField(
      {required TextEditingController controller, required validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                _toggle();
              },
              icon: Icon(_passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off)), //TODO: Add custom visibility icons
          border: const OutlineInputBorder(),
          hintText: "Enter your Password",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }

  TextFormField buildEmailFormField(
      {required TextEditingController controller, required validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your Email",
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
