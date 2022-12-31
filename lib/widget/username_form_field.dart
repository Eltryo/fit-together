import 'package:flutter/material.dart';

class UsernameFormField extends StatefulWidget {
  final TextEditingController usernameController;

  const UsernameFormField({required this.usernameController, Key? key})
      : super(key: key);

  @override
  State<UsernameFormField> createState() => _UsernameFormFieldState();
}

class _UsernameFormFieldState extends State<UsernameFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.usernameController,
        validator: (value) => //TODO: Add custom validator
            value == null || value.isEmpty ? "Please enter a username" : null,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your username",
            contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)));
  }
}