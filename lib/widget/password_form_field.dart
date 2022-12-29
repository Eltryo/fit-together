import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordFormField({required this.passwordController, Key? key})
      : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      validator: (password) {
        //TODO: Add custom validator
        if (password == null || password.isEmpty) {
          return "Please enter a password";
        }
        return null;
      },
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                _toggle();
              },
              //TODO: Add custom visibility icons
              icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off)),
          border: const OutlineInputBorder(),
          hintText: "Enter your password",
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
