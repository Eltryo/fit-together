import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/providers.dart';
import 'package:sports_app/widgets/route_builder.dart';

import '../widgets/email_form_field.dart';
import '../widgets/rounded_button_widget.dart';
import 'create_password_page.dart';

class CreateEmailPage extends StatefulWidget {
  const CreateEmailPage({Key? key}) : super(key: key);

  @override
  State<CreateEmailPage> createState() => _CreateEmailPageState();
}

class _CreateEmailPageState extends State<CreateEmailPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "E-Mail",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Text("Please enter your email address "),
              const SizedBox(height: 10),
              EmailFormField(
                emailController: emailController,
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, _) => RoundedButton(
                    text: "Next",
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      ref.read(emailProvider.notifier).state =
                          emailController.text;
                      Navigator.of(context).push(
                          RouteBuilder(widget: const CreatePasswordPage())
                              .buildRoute());
                    }),
              )
            ],
          ),
        )
      ]),
    ));
  }
}
