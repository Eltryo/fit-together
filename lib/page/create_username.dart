import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/page/route_builder.dart';
import 'package:sports_app/page/submit_registration.dart';
import 'package:sports_app/utils/colors.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

class CreateUsername extends StatefulWidget {
  const CreateUsername({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
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
        backgroundColor: AppColors.appBackgroundColor,
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text("Please enter your username"),
                    const SizedBox(height: 10),
                    UsernameFormField(usernameController: usernameController),
                    const SizedBox(height: 10),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref,
                              Widget? child) =>
                          RoundedButtonWidget(
                              text: "Next",
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                ref.read(usernameProvider.notifier).state =
                                    usernameController.text;
                                Navigator.of(context).push(RouteBuilder(
                                        widget: const SubmitRegistration())
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

  Consumer buildUsernameFormField(
      {required TextEditingController controller, required validator}) {
    return Consumer(builder: (context, ref, child) {
      return TextFormField(
        controller: controller,
        validator: validator,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your Username",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        onChanged: (text) {
          ref.read(MyApp.usernameProvider.notifier).state = text;
        },
      );
    });
  }
}
