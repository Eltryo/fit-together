import 'package:flutter/material.dart';
import 'package:sports_app/widgets/rounded_button_widget.dart';

import '../services/auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(),
        body: Center(
            //TODO: implement features
            child: RoundedButton(
                color: color,
                text: "Log out",
                onPressed: () async {
                  await _auth.signOut();
                  if (!mounted) return;
                  Navigator.of(context).pop();
                })));
  }
}
