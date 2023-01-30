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
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your email",
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }

  //TODO: extend validator functionality
  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'E-mail address is required.';
    }

    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    if (!regex.hasMatch(formEmail)) {
      return 'Invalid E-mail Address format.';
    }

    return null;
  }
}
