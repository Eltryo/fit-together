import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

class CreateUsername extends StatefulWidget {
  const CreateUsername({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  //TODO: dispose controller
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Username",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const Text("Please enter your username"),

          const SizedBox(height: 10),

          //form field for email
          buildUsernameFormField(
            controller: usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter an username";
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          RoundedButtonWidget(
              text: "Next",
              onPressed: () {
                //TODO: create user with controllers accordingly
              })
        ],
      ),
    );
  }

  TextFormField buildUsernameFormField(
      {required TextEditingController controller, required validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your Username",
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }
}
