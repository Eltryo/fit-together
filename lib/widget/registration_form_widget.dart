import 'package:flutter/material.dart';
import 'package:sports_app/page/create_password.dart';
import 'package:sports_app/page/route_builder.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

class RegistrationFormWidget extends StatefulWidget {
  //TODO: separate into registration and login validation form
  const RegistrationFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Registration",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const Text("Please enter your email address "),

          const SizedBox(height: 10),

          //form field for email
          buildEmailFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter an email";
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          RoundedButtonWidget(
              text: "Next",
              onPressed: () {
                Navigator.of(context).push(RouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CreatePassword()));
              })
        ],
      ),
    );
  }

  TextFormField buildEmailFormField(
      {required TextEditingController controller, required validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your Email",
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }
}
