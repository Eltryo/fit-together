import 'package:flutter/material.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController emailController;

  const EmailFormField({
    required this.emailController,
    Key? key,
  }) : super(key: key);

  @override
  State<EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your email",
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }
}
