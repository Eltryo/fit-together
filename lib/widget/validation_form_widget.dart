import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../services/auth.dart';

class ValidationFormWidget extends StatefulWidget {
  final String entry;

  const ValidationFormWidget({
    required this.entry,
    Key? key,
  }) : super(key: key);

  @override
  State<ValidationFormWidget> createState() => _ValidationFormWidgetState();
}

class _ValidationFormWidgetState extends State<ValidationFormWidget> {
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.entry,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          //form field for email
          buildTextFormField(
            hint: "Email",
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
          buildTextFormField(
            hint: "Password",
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
                // if (_formKey.currentState!.validate()) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text("Processing Data")));
                // }

                if (widget.entry == "Login") {
                  _auth.signInToAccount(
                      emailController.text, passwordController.text);
                } else if (widget.entry == "Registration") {
                  _auth.createAccount(
                      emailController.text, passwordController.text);
                }
              })
        ],
      ),
    );
  }

  TextFormField buildTextFormField( //TODO: separate function into email and password form field
      {required String hint,
      required TextEditingController controller,
      required validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: hint == "Password" ? !_passwordVisible : false,
      decoration: InputDecoration(
          suffixIcon: hint == "Password"
              ? IconButton(
                  onPressed: () {
                    _toggle();
                  },
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off))
              : null, //TODO: Add custom visibility icons
          border: const OutlineInputBorder(),
          hintText: "Enter your $hint",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
