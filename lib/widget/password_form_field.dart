import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController passwordController;
  final WidgetRef? ref;

  const PasswordFormField(
      {required this.passwordController, this.ref, Key? key})
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
        validator: (value) {
          if (value == null || value.isEmpty) {
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
                icon: Icon(_passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off)),
            //TODO: Add custom visibility icons
            border: const OutlineInputBorder(),
            hintText: "Enter your Password",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        onChanged: (text) => widget.ref
            ?.read(MyApp.passwordProvider.notifier)
            .state = text //only feed provider if ref is not null
        );
  }

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
