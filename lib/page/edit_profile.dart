import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../services/auth.dart';
import '../utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.appIconColor),
        ),
        body: Center(
            //TODO: implement edit features
            child: RoundedButtonWidget(
                color: color,
                text: "log out",
                onPressed: () async {
                  await _auth.signOut(); //TODO: fix sign out
                  debugPrint("sign out process is done");

                  if (!mounted) return;
                  Navigator.of(context).pop();
                })));
  }
}
