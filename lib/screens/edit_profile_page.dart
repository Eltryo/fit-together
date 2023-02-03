import 'package:fit_together/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          //TODO: implement features
          children: [
            RoundedButton(
              color: Theme.of(context).primaryColor,
              text: "Log out",
              onPressed: () {
                _auth.signOut();
                if(mounted){
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
