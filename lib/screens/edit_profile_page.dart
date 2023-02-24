import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authService = locator<AuthenticationService>();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          //TODO: implement features
          children: [
            RoundedButton(
              text: "Log out",
              onPressed: () {
                authService.signOut();
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
