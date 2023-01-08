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
    //TODO: add validator
    return TextFormField(
        controller: widget.usernameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your username",
            contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)));
  }
}
