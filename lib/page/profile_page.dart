import 'package:flutter/material.dart';
import 'package:sports_app/utils/user_preferences.dart';

import '../widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async{},
          )
        ],
      ),
    );
  }
}
