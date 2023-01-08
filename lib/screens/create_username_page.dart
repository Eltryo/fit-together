import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/screens/submit_registration_page.dart';
import 'package:sports_app/providers.dart';
import 'package:sports_app/widgets/rounded_button_widget.dart';
import 'package:sports_app/widgets/route_builder.dart';
import 'package:sports_app/widgets/username_form_field.dart';

class CreateUsernamePage extends StatefulWidget {
  const CreateUsernamePage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUsernamePage> createState() => _CreateUsernamePageState();
}

class _CreateUsernamePageState extends State<CreateUsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
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
                  "Username",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text("Please enter your username"),
                const SizedBox(height: 10),
                UsernameFormField(usernameController: usernameController),
                const SizedBox(height: 10),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) =>
                          RoundedButton(
                              text: "Next",
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                ref.read(usernameProvider.notifier).state =
                                    usernameController.text;
                                Navigator.of(context).push(RouteBuilder(
                                        widget: const SubmitRegistrationPage())
                                    .buildRoute());
                              }),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
