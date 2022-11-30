import 'package:flutter/material.dart';
import 'package:sports_app/page/route_builder.dart';

import '../utils/colors.dart';
import '../widget/rounded_button_widget.dart';
import 'create_password.dart';

//TODO: try using ChangeNotifierProviders
class CreateEmail extends StatefulWidget {
  const CreateEmail({Key? key}) : super(key: key);

  @override
  State<CreateEmail> createState() => CreateEmailState();
}

//TODO: think of better solution than making state public
class CreateEmailState extends State<CreateEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

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
                        email;
                        Navigator.of(context).push(RouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const CreatePassword()));
                      })
                ],
              ),
            )
          ]),
        ));
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

  String get email {
    return emailController.text;
  }
}
