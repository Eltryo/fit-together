import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import '../../services/auth.dart';
import '../../utils/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final AuthService _auth = AuthService();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.appIconColor),
        ),
        body: Center(
            child: RoundedButtonWidget(
                color: color,
                text: "log out",
                onPressed: () async {
                  await _auth.signOut(); //TODO: Give feedback
                })));
  }
}
