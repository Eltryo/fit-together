import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/route_builder.dart';

import '../utils/colors.dart';
import '../widget/email_form_field.dart';
import '../widget/rounded_button_widget.dart';
import 'create_password.dart';

class CreateEmail extends StatefulWidget {
  const CreateEmail({Key? key}) : super(key: key);

  @override
  State<CreateEmail> createState() => _CreateEmailState();
}

class _CreateEmailState extends State<CreateEmail> {
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
        backgroundColor: AppColors.appBackgroundColor,
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
                    builder: (BuildContext context, WidgetRef ref,
                            Widget? child) =>
                        RoundedButtonWidget(
                            text: "Next",
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              ref.read(emailProvider.notifier).state =
                                  emailController.text;
                              Navigator.of(context).push(
                                  RouteBuilder(widget: const CreatePassword())
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
