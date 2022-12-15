import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/create_username.dart';
import 'package:sports_app/page/route_builder.dart';

import '../main.dart';
import '../widget/rounded_button_widget.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key? key}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),

                    const Text("Please enter a save password"),

                    const SizedBox(height: 10),

                    //form field for email
                    buildPasswordFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a password";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    RoundedButtonWidget(
                        text: "Next",
                        onPressed: () {
                          Navigator.of(context).push(RouteBuilder(widget: const CreateUsername()).buildRoute());
                        })
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Consumer buildPasswordFormField(
      {required TextEditingController controller, required validator}) {
    return Consumer(builder: (context, ref, child) {
      return TextFormField(
        controller: controller,
        validator: validator,
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
        onChanged: (text) {
          ref.read(MyApp.passwordProvider.notifier).state = text;
        },
      );
    });
  }

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
