import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController emailController;
  final WidgetRef? ref;

  const EmailFormField({required this.emailController, this.ref, Key? key})
      : super(key: key);

  @override
  State<EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.emailController,
        validator: (value) =>
            value == null || value.isEmpty ? "Please enter a email" : null,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your Email",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        onChanged: (text) =>
            widget.ref?.read(MyApp.emailProvider.notifier).state = text);
  }
}
