import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/create_username.dart';
import 'package:sports_app/page/route_builder.dart';

import '../widget/password_form_field.dart';
import '../widget/rounded_button_widget.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({Key? key}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

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
                    Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                                Widget? child) =>
                            PasswordFormField(
                                passwordController: passwordController,
                                ref: ref)),
                    //TODO make controller not required
                    const SizedBox(height: 10),
                    RoundedButtonWidget(
                        text: "Next",
                        onPressed: () {
                          Navigator.of(context).push(
                              RouteBuilder(widget: const CreateUsername())
                                  .buildRoute());
                        })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
