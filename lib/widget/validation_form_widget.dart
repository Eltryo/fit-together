import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../services/auth.dart';

class ValidationFormWidget extends StatefulWidget {
  final String entry;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const ValidationFormWidget({
    required this.entry,
    required this.emailController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  State<ValidationFormWidget> createState() => _ValidationFormWidgetState();
}

class _ValidationFormWidgetState extends State<ValidationFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

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
          buildTextFormField("email", widget.emailController),

          const SizedBox(height: 10),

          //form field for password
          buildTextFormField("password", widget.passwordController),

          const SizedBox(height: 10),

          RoundedButtonWidget(
              text: "Submit",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Processing Data")));
                }

                _auth.createAccount(widget.emailController.text,
                    widget.passwordController.text);
              })
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a $hint";
        }
        return null;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Enter your $hint",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }
}
