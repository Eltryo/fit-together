import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_together/screens/create_username_page.dart';
import 'package:fit_together/providers.dart';
import 'package:fit_together/widgets/route_builder.dart';

import '../widgets/password_form_field.dart';
import '../widgets/rounded_button_widget.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({Key? key}) : super(key: key);

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
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
                    PasswordFormField(
                      passwordController: passwordController,
                    ),
                    const SizedBox(height: 10),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref,
                              Widget? child) =>
                          RoundedButton(
                              text: "Next",
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                ref.read(passwordProvider.notifier).state =
                                    passwordController.text;
                                Navigator.of(context).push(RouteBuilder(
                                        widget: const CreateUsernamePage())
                                    .buildRoute());
                              }),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
