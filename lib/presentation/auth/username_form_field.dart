import 'package:flutter/material.dart';

class UsernameFormField extends StatelessWidget {
  final TextEditingController usernameController;

  const UsernameFormField({
    required this.usernameController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your username",
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }
}
